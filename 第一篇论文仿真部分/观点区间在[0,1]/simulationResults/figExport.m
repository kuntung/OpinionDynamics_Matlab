%���ڽ�fig��ʽ�ķ�����ͼ����Ϊ�������õ�eps�ļ�
%ʹ��export_fig
function figExport(type,Tag,path,epsilo_L,epsilo_R,a,b)
set(gcf, 'Color', 'w');%����ǰfig�ı�����Ϊ��ɫ
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