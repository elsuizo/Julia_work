using Images, Color 

# build a sample image 
datafloat = reshape(linspace(0.5, 1.5, 60000), 200, 300) 
# convert the raw 0.5:1.5 data to a integer type, so we can index 
dataint = iround(Uint8, 254*(datafloat - 0.5) + 1)  # ranges from 1 to 255 
# build our colormap 
b = RGB(0,0,1) 
w = RGB(1,1,1) 
r = RGB(1,0,0) 
cmaprgb = Array(RGB, 255) 
f = linspace(0,1,128) 
cmaprgb[ 1:128] = [ (1-x)*b + x*w for x in f] 
cmaprgb[ 129:end] = [ (1-x)*w + x*r for x in f[ 2:end]] 


img = ImageCmap(dataint, cmaprgb) 


imwrite(img,"image.jpg")
