
function count_letters(T::UTF8String)
    # Compute the probabilities of letters
    d = Dict{Char, FloatingPoint}()
    prob = [length(find(T.data .== letter)) for letter in Set(T)] / (length(T))
    d = {letter => i for i in prob, letter in Set(T)}
     
    return d,prob

end
     

