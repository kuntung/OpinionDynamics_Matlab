function autoSaveIm(path,epsilo_L,epsilo_R,a,b)
saveas(gca,[path, 'epsiloL',num2str(epsilo_L),'epsiloR',num2str(epsilo_R),'a',num2str(a),'b',num2str(b)],'jpg');%±£´æÍ¼Æ¬
close
end