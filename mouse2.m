clc
clear
load mouse.txt;
x = 1;
for i=1:49800
  if(mod(i, 43)==0)
  nuevo(x, 1) = mouse(i, 1);
  nuevo(x, 2) = mouse(i, 2);
  x++;
end
end

csvwrite("mouseS.txt", nuevo);