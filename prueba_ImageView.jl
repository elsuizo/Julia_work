using Tk
using Images
using ImageView

img = imread("/home/elsuizo/Imagenes/lyapunov.jpg")
imgc, imgslice = view(img);

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
