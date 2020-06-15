load mouse.txt
x = 1;
for i=1:52500
  if(mod(i, 45)==0)
  nuevo(x, 1) = mouse(i, 1);
  nuevo(x, 2) = mouse(i, 2);
end
end