function Histogram = CalcHOG(G,theta,nBins)

%create blank histogram
Histogram = zeros(1,nBins);
bin_interval = 180/nBins;

[rows,cols] = size(G);

%calculate histogram
for r = 1:1:rows
    for c = 1:1:cols
        %calculate the contribution of each direction 
        %to its adjacent bins
        if isnan(theta(r,c)) == 1
              continue;
        else
            lower_bin = floor(theta(r,c)/bin_interval)+1;
            upper_bin = lower_bin+1;

            lower_degree = floor(theta(r,c)/bin_interval)*bin_interval;
            upper_degree = lower_degree + bin_interval;

            if (lower_bin > nBins)
                lower_bin = mod(lower_bin,nBins);
            end
            
            if (upper_bin > nBins)
                upper_bin = mod(upper_bin,nBins);
            end

            proportion_lower = abs(theta(r,c)-lower_degree)/bin_interval;
            proportion_upper = abs(theta(r,c)-upper_degree)/bin_interval;
            
            if proportion_lower < 10^-5
                proportion_lower = 0;
            end
            
            if proportion_upper < 10^-5
                proportion_upper = 0;
            end


            Histogram(1,lower_bin) = Histogram(1,lower_bin) + proportion_upper*G(r,c);
            Histogram(1,upper_bin) = Histogram(1,upper_bin) + proportion_lower*G(r,c);
        end
        
    end
end



end