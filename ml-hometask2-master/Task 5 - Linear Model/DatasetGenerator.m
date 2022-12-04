x1 = rand(500,1);
x2 = rand(500,1);
x3 = 2 .* x1;
x4 = -7 .* x1 - 5;
x5 = x4 + x2;
x6 = sin(x3);
x7 = rand(500,1);
x8 = rand(500,1);

y = 2 .* x1 -8 .* x2 + x3 - x4 + 3 .* x5 + x6 - 3 .* x7;

D = [ x1 x2 x3 x4 x5 x6 x7 x8 y] 

noiseIndices = [ 1, 60, 89, 107, 432];

for i = 1:length(noiseIndices)
    noise = noiseIndices(i);
    D(noise,:) = rand(1,9);
end

