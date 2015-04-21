using Tk
using Images
using ImageView


img = imread("/home/elsuizo/Images/12096.jpg")
#imgc, imgslice = view(img);

c = canvasgrid(2,2)
ops = [:pixelspacing => [1,1]]
view(c[1,1], img)
view(c[1,2], img)
view(c[2,1], img)
view(c[2,2], img)

#If we are not in a REPL
if (!isinteractive())

    # Create a condition object
    c = Condition()

    # Get the main window (A Tk toplevel object)
    win = toplevel(imgc)

    # Notify the condition object when the window closes
    bind(win, "<Destroy>", e->notify(c))

    # Wait for the notification before proceeding ... 
    wait(c)
end
