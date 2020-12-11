function autoSaveOpinion(path,epsilo_L,epsilo_R,a,b,tag)
saveas(gcf,[path,'epsiloL',num2str(epsilo_L),'epsiloR',num2str(epsilo_R),'a',num2str(a),'b',num2str(b),tag,'.fig']);%±£´æÍ¼Æ¬
close
end