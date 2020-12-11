function matrix = FreeScale(X)
%����FreeScale��200�����ɽ���һ����ʼ���Ϊ3�����ս��Ϊ200���ޱ������
N= X; m0= 3; m= 3;%��ʼ����������
adjacent_matrix = sparse( m0, m0);% ��ʼ���ڽӾ���
for i = 1: m0
    for j = 1:m0
        if j ~= i      %ȥ��ÿ���������γɵĻ�
            adjacent_matrix(i,j) = 1;%������ʼ�ڽӾ���3��ͬ��ͬ�����ĵ�����
        end
    end
end
adjacent_matrix =sparse(adjacent_matrix);%�ڽӾ���ϡ�軯
node_degree = zeros(1,m0+1);                %��ʼ����Ķ�
node_degree(2: m0+1) = sum(adjacent_matrix);%�Զ�ά��������չ
for iter= 4:N
    iter;                               %�ӵ�
    total_degree = 2*m*(iter- 4)+6;%���������д˵�Ķ�֮��
    cum_degree = cumsum(node_degree);%��������е�ĶȾ���
    choose= zeros(1,m);%��ʼ��ѡ�����
    % ѡ����һ�����µ������ӵĶ���
    r1= rand(1)*total_degree;%�����ɵ������ĸ���
    for i= 1:iter-1
        if (r1>=cum_degree(i))&&( r1<cum_degree(i+1))%ѡȡ�ȴ�ĵ�
            choose(1) = i;
            break
        end
    end
    % ѡ���ڶ������µ������ӵĶ���
    r2= rand(1)*total_degree;
    for i= 1:iter-1
        if (r2>=cum_degree(i))&&(r2<cum_degree(i+1))
            choose(2) = i;
            break
        end
    end
    while choose(2) == choose(1)%��һ����͵ڶ�������ͬ�Ļ�����������
        r2= rand(1)*total_degree;
        for i= 1:iter-1
            if (r2>=cum_degree(i))&&(r2<cum_degree(i+1))
                choose(2) = i;
                break
            end
        end
    end
    % ѡ�����������µ������ӵĶ���
    r3= rand(1)*total_degree;
    for i= 1:iter-1
        if  (r3>=cum_degree(i))&&(r3<cum_degree(i+1))
            choose(3) = i;
            break
        end
    end
    while (choose(3)==choose(1))||(choose(3)==choose(2))
        r3= rand(1)*total_degree;
        for i=1:iter-1
            if (r3>=cum_degree(i))&&(r3<cum_degree(i+1))
                choose(3) = i;
                break
            end
        end
    end
    %�µ���������, ���ڽӾ�����и���
    for k = 1:m
        adjacent_matrix(iter,choose(k)) = 1;
        adjacent_matrix(choose(k),iter) = 1;
    end
    node_degree=zeros(1,iter+1);
    node_degree(2:iter+1) = sum(adjacent_matrix);
end
matrix = adjacent_matrix;
% tu_plot(matrix,0);%������ǰ������ͼ
end

