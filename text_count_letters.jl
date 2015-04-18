
function count_letters(T)

    vec = zeros(256)
    counter = 0
    letters = [0x00:0xff]
    
    for i in 1:length(T)
        counter = 0
        for letter in letters
            if(T.data[i] == letter )
                counter += 1
            end
        end
        vec[i] = counter
    end

    return vec

end

        

