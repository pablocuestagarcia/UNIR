%% =========================================================================
%  GREY WOLF OPTIMIZER (GWO) APLICADO AL TRAVELLING SALESMAN PROBLEM (TSP)
%  -------------------------------------------------------------------------
%  Asignatura : Computación Bioinspirada
%  Actividad  : 1 - Algoritmos de adaptación social
%  Autor      : Pablo de la Cuesta García
%  Email      : pablodelacuestagarcia@gmail.com
%
%  Descripción
%  -----------
%  Este script implementa una variante DISCRETA del Grey Wolf Optimizer
%  (Mirjalili et al., 2014) adaptada al Travelling Salesman Problem.
%
%  En la versión continua, cada lobo es un vector real X y la actualización
%  de la posición se basa en el operador
%
%       D = |C * X_lider - X|
%       X_nueva = X_lider - A * D
%
%  Para problemas combinatorios como TSP (recorrido = permutación de n
%  ciudades) esa fórmula no tiene sentido porque la distancia entre
%  permutaciones no se mide aritméticamente. Por eso adaptamos el GWO
%  utilizando operadores discretos:
%
%       - "Movimiento" hacia un líder  --> Order Crossover (OX)
%       - "Distancia" / exploración    --> mutación por intercambio (swap)
%       - Refinamiento local           --> 2-opt (probabilidad reducida)
%
%  El parámetro a sigue decreciendo linealmente de 2 a 0, controlando
%  exploración (a alto -> más swaps aleatorios) frente a explotación
%  (a bajo -> más cruces con los líderes y 2-opt).
%
%  El script
%       1) Genera (o carga) una instancia TSP.
%       2) Ejecuta el DGWO durante maxIter iteraciones.
%       3) Compara con un baseline: vecino más cercano (Nearest Neighbour).
%       4) Genera gráficas de convergencia y del tour final.
%       5) Realiza varias corridas independientes y reporta estadísticas.
%
%  INSTRUCCIONES DE EJECUCION
%  --------------------------
%  MATLAB:
%       1) Abrir MATLAB.
%       2) Cambiar el Current Folder a la carpeta que contiene este fichero:
%          .../actividad_1/matlab
%       3) Pulsar Run, o escribir en la Command Window:
%              main_GWO_TSP
%
%  Octave:
%       1) Abrir GNU Octave.
%       2) Cambiar a esta carpeta con cd.
%       3) Ejecutar:
%              main_GWO_TSP
%
%  El script no requiere toolboxes: genera la instancia, ejecuta el DGWO,
%  imprime las estadisticas en consola y muestra las graficas.
%  =========================================================================

clear; clc; close all;

%% ---------- CONFIGURACIÓN -----------------------------------------------
cfg.nCities    = 30;       % número de ciudades en la instancia aleatoria
cfg.seed       = 42;       % semilla para reproducibilidad
cfg.nWolves    = 30;       % tamaño de la manada
cfg.maxIter    = 300;      % iteraciones del algoritmo
cfg.pTwoOpt    = 0.10;     % probabilidad de aplicar 2-opt a un lobo
cfg.nRuns      = 10;       % corridas independientes para estadísticas
cfg.usePreset  = false;    % si true, usa instancia predefinida (berlin-like)

%% ---------- INSTANCIA TSP -----------------------------------------------
rng(cfg.seed);

if cfg.usePreset
    % Pequeña instancia "berlin-like" embebida (subconjunto representativo)
    cities = [565,575; 25,185; 345,750; 945,685; 845,655; 880,660;
              25,230;  525,1000; 580,1175;650,1130;1605,620;1220,580;
              1465,200; 1530,5;  845,680; 725,370; 145,665; 415,635;
              510,875;  560,365; 300,465; 520,585; 480,415; 835,625;
              975,580;  1215,245;1320,315;1250,400; 660,180; 410,250];
    cfg.nCities = size(cities,1);
else
    cities = 100 * rand(cfg.nCities, 2);
end

D = computeDistMatrix(cities);  % matriz de distancias (precomputada)

%% ---------- BASELINE: NEAREST NEIGHBOUR ---------------------------------
nnTour   = nearestNeighbour(D);
nnLength = tourLength(nnTour, D);

%% ---------- EJECUCIONES MÚLTIPLES ---------------------------------------
allLengths = zeros(cfg.nRuns, 1);
allConv    = zeros(cfg.nRuns, cfg.maxIter);
bestRunIdx = 1; bestRunLen = Inf; bestRunTour = [];

fprintf('Ejecutando %d corridas independientes de DGWO...\n', cfg.nRuns);
for r = 1:cfg.nRuns
    rng(cfg.seed + r);          % semilla diferente por corrida
    tic;
    [tour, len, conv] = DGWO_TSP(D, cfg.nWolves, cfg.maxIter, cfg.pTwoOpt);
    t = toc;

    allLengths(r)  = len;
    allConv(r,:)   = conv;

    if len < bestRunLen
        bestRunLen  = len;
        bestRunTour = tour;
        bestRunIdx  = r;
    end
    fprintf('  Corrida %2d/%d: longitud = %.2f  (%.2fs)\n', ...
        r, cfg.nRuns, len, t);
end

%% ---------- INFORME EN CONSOLA ------------------------------------------
fprintf('\n=========== RESULTADOS ===========\n');
fprintf('Ciudades            : %d\n', cfg.nCities);
fprintf('Lobos / iteraciones : %d / %d\n', cfg.nWolves, cfg.maxIter);
fprintf('--- DGWO (%d corridas) ---\n', cfg.nRuns);
fprintf('  Mejor      : %.2f\n', min(allLengths));
fprintf('  Media      : %.2f\n', mean(allLengths));
fprintf('  Desv.tip.  : %.2f\n', std(allLengths));
fprintf('  Peor       : %.2f\n', max(allLengths));
fprintf('--- BASELINE Nearest-Neighbour ---\n');
fprintf('  Longitud   : %.2f\n', nnLength);
fprintf('--- COMPARATIVA ---\n');
fprintf('  Mejora vs NN (mejor) : %.2f%%\n', ...
    100*(nnLength-min(allLengths))/nnLength);
fprintf('  Mejora vs NN (media) : %.2f%%\n', ...
    100*(nnLength-mean(allLengths))/nnLength);
fprintf('==================================\n');

%% ---------- GRÁFICAS ----------------------------------------------------
% 1. Convergencia: media + min/max envelope
figure('Name','Convergencia DGWO','Color','w','Position',[100 100 700 400]);
meanConv = mean(allConv,1);
minConv  = min(allConv,[],1);
maxConv  = max(allConv,[],1);
xs = 1:cfg.maxIter;
fill([xs fliplr(xs)],[minConv fliplr(maxConv)], ...
     [0.8 0.85 0.95],'EdgeColor','none','FaceAlpha',0.6); hold on;
plot(xs, meanConv, 'b-','LineWidth',2);
plot(xs, allConv(bestRunIdx,:), 'r-','LineWidth',1.5);
drawHorizontalLine(nnLength, 'k--', 1.2);
legend({'rango [min,max]','media','mejor corrida','Nearest Neighbour'}, ...
       'Location','northeast');
xlabel('Iteración'); ylabel('Longitud del mejor tour (\alpha)');
title(sprintf('Convergencia DGWO  (n=%d, lobos=%d)', cfg.nCities, cfg.nWolves));
grid on; box on;

% 2. Tour final
figure('Name','Mejor tour encontrado','Color','w','Position',[820 100 600 500]);
plotTour(cities, bestRunTour, [0.85 0.15 0.15], 'DGWO');
title(sprintf('Mejor tour DGWO  (L = %.2f)', bestRunLen));

% 3. Tour Nearest Neighbour para comparar
figure('Name','Tour Nearest Neighbour','Color','w','Position',[820 640 600 500]);
plotTour(cities, nnTour, [0.15 0.45 0.85], 'NN');
title(sprintf('Tour Nearest Neighbour  (L = %.2f)', nnLength));

% 4. Estadisticas de resultados sin depender de boxplot/toolboxes
figure('Name','Estadísticas','Color','w','Position',[100 560 500 350]);
plotSimpleBox(allLengths, 1, [0.25 0.45 0.85]); hold on;
hNN = drawHorizontalLine(nnLength,'r--',1.2);
xlim([0.5 1.5]); set(gca,'XTick',1,'XTickLabel',{'DGWO'});
ylabel('Longitud del tour'); grid on;
title(sprintf('Distribución (%d corridas) vs NN', cfg.nRuns));
legend(hNN, {'NN baseline'},'Location','best');

%% =========================================================================
%  =================== FUNCIONES LOCALES (algoritmo) =======================
%  =========================================================================

% -------------------------------------------------------------------------
function [bestTour, bestLen, conv] = DGWO_TSP(D, nWolves, maxIter, pTwoOpt)
% DGWO_TSP  Discrete Grey Wolf Optimizer para TSP.
%   D       : matriz de distancias n x n
%   nWolves : tamaño de la manada
%   maxIter : iteraciones
%   pTwoOpt : probabilidad de aplicar 2-opt local search
%
% Devuelve la mejor permutación encontrada (alpha), su longitud, y el
% vector de convergencia (longitud del alpha en cada iteración).

n = size(D,1);

% --- 1. Inicialización aleatoria de la manada ---
wolves  = zeros(nWolves, n);
fitness = zeros(nWolves, 1);
for i = 1:nWolves
    wolves(i,:)  = randperm(n);
    fitness(i)   = tourLength(wolves(i,:), D);
end

% --- 2. Identifica los tres líderes (alpha, beta, delta) ---
[alpha, beta, delta, fA, fB, fD] = updateLeaders(wolves, fitness);

conv = zeros(1, maxIter);

% --- 3. Bucle principal ---
for t = 1:maxIter
    a = 2 - 2*(t-1)/(maxIter-1);   % decrece linealmente de 2 a 0

    for i = 1:nWolves
        % Para cada líder se calcula |A| que en GWO continuo decide si el
        % lobo se acerca (|A|<1) o se aleja (|A|>1) del líder. Aquí lo
        % usamos para decidir cuántos swaps aleatorios (perturbación)
        % aplicar después del cruce.
        A1 = 2*a*rand() - a;
        A2 = 2*a*rand() - a;
        A3 = 2*a*rand() - a;

        % Cruce con cada líder (Order Crossover) ---
        X1 = orderCrossover(wolves(i,:), alpha);
        X2 = orderCrossover(wolves(i,:), beta);
        X3 = orderCrossover(wolves(i,:), delta);

        % Perturbación según |A| (más exploración cuando a es alto) ---
        X1 = swapMutation(X1, round(abs(A1)));
        X2 = swapMutation(X2, round(abs(A2)));
        X3 = swapMutation(X3, round(abs(A3)));

        % Selecciona el mejor de los tres candidatos ---
        f1 = tourLength(X1, D);
        f2 = tourLength(X2, D);
        f3 = tourLength(X3, D);
        cand   = {X1, X2, X3};
        [fNew, idx] = min([f1 f2 f3]);
        newWolf = cand{idx};

        % Refinamiento local con 2-opt (con baja probabilidad) ---
        if rand() < pTwoOpt
            [newWolf, fNew] = twoOptLocalSearch(newWolf, D, 1);
        end

        % Reemplazo elitista: solo aceptamos si mejora -----------------
        % Esto evita degradar lobos buenos y acelera convergencia.
        if fNew < fitness(i)
            wolves(i,:) = newWolf;
            fitness(i)  = fNew;
        end
    end

    % --- Actualiza líderes con la nueva manada ---
    [alpha, beta, delta, fA, fB, fD] = updateLeaders(wolves, fitness);

    conv(t) = fA;
end

bestTour = alpha;
bestLen  = fA;
end

% -------------------------------------------------------------------------
function [alpha, beta, delta, fA, fB, fD] = updateLeaders(wolves, fitness)
% Selecciona los tres mejores lobos (alpha mejor, delta tercero).
[~, idx] = sort(fitness, 'ascend');
alpha = wolves(idx(1),:);   fA = fitness(idx(1));
beta  = wolves(idx(2),:);   fB = fitness(idx(2));
delta = wolves(idx(3),:);   fD = fitness(idx(3));
end

% -------------------------------------------------------------------------
function child = orderCrossover(parent1, parent2)
% Order Crossover (OX): conserva un segmento de parent1 y rellena el resto
% con el orden de aparición en parent2. Es el operador clásico para
% representaciones por permutación porque produce siempre tours válidos.
n = length(parent1);
% Selecciona dos puntos de corte aleatorios
pts = sort(randperm(n,2));
i1 = pts(1); i2 = pts(2);

child = zeros(1,n);
child(i1:i2) = parent1(i1:i2);                  % copia segmento de p1

% Rellena el resto con el orden de p2 saltando los ya copiados
mask = ~ismember(parent2, child(i1:i2));
queue = parent2(mask);

% Posiciones libres en orden circular comenzando tras i2
positions = [i2+1:n, 1:i1-1];
child(positions) = queue;
end

% -------------------------------------------------------------------------
function tour = swapMutation(tour, nSwaps)
% Aplica nSwaps intercambios aleatorios de dos posiciones en la
% permutación. Es el operador de "exploración" (rompe estructura).
n = length(tour);
for k = 1:nSwaps
    ij = randperm(n,2);
    tour([ij(1) ij(2)]) = tour([ij(2) ij(1)]);
end
end

% -------------------------------------------------------------------------
function [bestTour, bestLen] = twoOptLocalSearch(tour, D, maxPasses)
% 2-opt: invierte el subsegmento entre i y j si reduce la longitud.
% Operador estándar de búsqueda local en TSP. maxPasses limita el coste.
n = length(tour);
bestTour = tour;
bestLen  = tourLength(tour, D);
for pass = 1:maxPasses
    improved = false;
    for i = 1:n-1
        for j = i+1:n
            if i == 1 && j == n
                continue; % invertir todo el tour solo cambia el sentido
            end
            % delta de longitud al revertir tour(i+1:j), con cierre circular
            a = bestTour(i);   b = bestTour(i+1);
            c = bestTour(j);   d = bestTour(mod(j,n)+1);
            delta = (D(a,c) + D(b,d)) - (D(a,b) + D(c,d));
            if delta < -1e-10
                bestTour(i+1:j) = bestTour(j:-1:i+1);
                bestLen = bestLen + delta;
                improved = true;
            end
        end
    end
    if ~improved, break; end
end
end

% -------------------------------------------------------------------------
function L = tourLength(tour, D)
% Longitud total de un tour cerrado (vuelve a la ciudad inicial).
idx1 = tour;
idx2 = [tour(2:end) tour(1)];
L = sum(D(sub2ind(size(D), idx1, idx2)));
end

% -------------------------------------------------------------------------
function D = computeDistMatrix(cities)
% Distancias euclídeas precomputadas.
n = size(cities,1);
D = zeros(n,n);
for i = 1:n
    for j = i+1:n
        D(i,j) = norm(cities(i,:) - cities(j,:));
        D(j,i) = D(i,j);
    end
end
end

% -------------------------------------------------------------------------
function tour = nearestNeighbour(D)
% Heurística baseline: empezar en ciudad 1 y siempre saltar al vecino
% no visitado más cercano. Da soluciones razonables muy rápido.
n = size(D,1);
tour = zeros(1,n);
visited = false(1,n);
tour(1) = 1; visited(1) = true;
for k = 2:n
    last = tour(k-1);
    d = D(last,:);
    d(visited) = Inf;
    [~, nxt] = min(d);
    tour(k) = nxt;
    visited(nxt) = true;
end
end

% -------------------------------------------------------------------------
function plotTour(cities, tour, color, label)
% Dibuja un tour cerrado sobre el plano de ciudades.
n = size(cities,1);
order = [tour tour(1)];
plot(cities(order,1), cities(order,2), '-', ...
     'Color', color, 'LineWidth', 1.8); hold on;
plot(cities(:,1), cities(:,2), 'ko', ...
     'MarkerFaceColor','k','MarkerSize',5);
% Etiquetas (solo si pocas ciudades, para no saturar)
if n <= 40
    for i = 1:n
        text(cities(i,1)+1.2, cities(i,2)+1.2, num2str(i), ...
             'FontSize',8,'Color',[0.3 0.3 0.3]);
    end
end
% Resalta inicio
plot(cities(tour(1),1), cities(tour(1),2), 's', ...
     'MarkerSize', 10, 'MarkerFaceColor', color, ...
     'MarkerEdgeColor','k','LineWidth',1.2);
xlabel('x'); ylabel('y'); axis equal; grid on;
end

% -------------------------------------------------------------------------
function h = drawHorizontalLine(y, style, lineWidth)
% Alternativa compatible a yline para MATLAB antiguo y Octave.
xl = xlim;
h = plot(xl, [y y], style, 'LineWidth', lineWidth);
xlim(xl);
end

% -------------------------------------------------------------------------
function plotSimpleBox(values, x, color)
% Boxplot minimo sin Statistics Toolbox: caja Q1-Q3, mediana y bigotes.
values = sort(values(:));
q1 = percentileLocal(values, 25);
med = percentileLocal(values, 50);
q3 = percentileLocal(values, 75);
vmin = min(values);
vmax = max(values);
w = 0.22;
patch([x-w x+w x+w x-w], [q1 q1 q3 q3], color, ...
      'EdgeColor', color, 'LineWidth', 1.2); hold on;
plot([x-w x+w], [med med], '-', 'Color', color, 'LineWidth', 2);
plot([x x], [vmin q1], '-', 'Color', color, 'LineWidth', 1.2);
plot([x x], [q3 vmax], '-', 'Color', color, 'LineWidth', 1.2);
plot([x-w/2 x+w/2], [vmin vmin], '-', 'Color', color, 'LineWidth', 1.2);
plot([x-w/2 x+w/2], [vmax vmax], '-', 'Color', color, 'LineWidth', 1.2);
plot(x*ones(size(values)), values, 'o', 'Color', color, ...
     'MarkerFaceColor', color, 'MarkerSize', 4);
end

% -------------------------------------------------------------------------
function q = percentileLocal(values, p)
% Percentil con interpolacion lineal, evitando depender de prctile.
n = numel(values);
if n == 1
    q = values(1);
    return;
end
pos = 1 + (n-1) * p / 100;
lo = floor(pos);
hi = ceil(pos);
if lo == hi
    q = values(lo);
else
    q = values(lo) + (pos-lo) * (values(hi)-values(lo));
end
end
