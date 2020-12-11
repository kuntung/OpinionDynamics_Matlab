%用于将fig格式的仿真结果图保存为论文所用的eps文件
%使用export_fig
function figExport(type,Tag,path,epsilo_L,epsilo_R,a,b)
set(gcf, 'Color', 'w');%将当前fig的背景设为白色
if nargin==2
    export_fig(Tag,type)
else
    if nargin==3
        export_fig(path,Tag,type)
    else
        if nargin==7
            export_fig(path,[sprintf('epsilonL%depsilonR%da%db%d',epsilo_L*100,epsilo_R*100,a*10,b*10),Tag],type)
        else
            error('If you want to save .fig with parameters, please check the expression above.')
        end
    end
% close
end
end