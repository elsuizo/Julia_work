
function count_letters(T)

    counter = 0
    letters = 0x00:0xff
    set = unique(T.data)
    d = Dict()
    
    for letter in set
        counter = 0
        for i in 1:length(T.data)
            if(letter == T.data[i] )
                
                counter += 1
                
                d[letter] = counter
            end
        end
    end

    return d

end

        

