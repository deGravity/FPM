function unwrapped = phase_unwrap( phase, mask, tau )
%PHASE_UNWRAP Summary of this function goes here
%http://www.opticsinfobase.org/view_article.cfm?gotourl=http%3A%2F%2Fwww%2Eopticsinfobase%2Eorg%2FDirectPDFAccess%2FE9E584BB-DDD3-0E8B-3EE3991E76640B64_226692%2Foe-20-3-2556%2Epdf%3Fda%3D1%26id%3D226692%26seq%3D0%26mobile%3Dno&org=
%   Detailed explanation goes here
unwrapped = zeros(size(phase));
mask = logical(mask);
corrected = ~mask;
[height, width] = size(phase);
for y = 1:height
    for x = 1:width
        if mask(y,x) ~= 0
            S = 0;
            count = 0;
            predictor = 0;
            for m = max(y-1,1) : min(y+1,height)
                for n = max(x-1,1) : min(x+1,width)
                    S = S + mask(m, n)*corrected(m,n);
                    count = count + mask(m,n);
                    predictor = predictor + unwrapped(m, n);
                end
            end
            predictor = predictor / count;
            corrector = 0;
            for m = max(y-1,1) : min(y+1,height)
                for n = max(x-1,1) : min(x+1,width)
                    corrector = corrector + W( phase(m, n) - predictor )*mask(m,n)*(~corrected(m,n));
                end
            end
            corrected(y,x) = true;
            unwrapped(y,x) = predictor + tau * corrector;
        end
    end
end

end

function wrap = W(x)
    wrap = mod(x, pi)*sign(x);
end

