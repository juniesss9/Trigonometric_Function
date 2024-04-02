function result = my_cos(x)
    result = 0;
    n = 10; % 展开项数，可以根据需要调整
    for k = 0:n
        result = result + ((-1)^k * x^(2*k)) / factorial(2*k);
    end
end

