function [cm,avg_error]=evaluation(examples,targets)

N=10;
c=1;
[examples_no, columns]=size(examples);
actual=[];
predicted=[];
for i=1:examples_no/N:examples_no
    test_data=examples(i:i+N-1,:);
    test_targets=targets(i:i+N-1);
    train_data=examples;
    train_data(i:i+N-1,:)=[];
    train_target=targets;
    train_target(i:i+N-1)=[];
    for k=1:6
        trees(k)=DTL(train_data,train_target,k);
    end
    
    y=testTrees(trees,test_data);
    y(y==0)=mode(test_targets);
    
    predicted=[predicted y']
    actual=[actual test_targets']
    
    e(c)=0;
    
    [test_targets_no, columns]=size(test_targets);
    for j=1:test_targets_no
        if y(j)~=test_targets(j)
            e(c)=e(c)+1;
        end
    end
    e(c)=e(c)/N;
    c=c+1;
    
end

sum=0;
for c=1:N
    sum=sum+e(c);
end
avg_error=(1/N)*sum;
length(actual)
cm=conf_matrix(actual, predicted);
end

function y=testTrees(trees,test_data)

[test_data_rows,test_data_columns]=size(test_data);
y=zeros(10,1);
for i=1:test_data_rows
    for k=1:6
        ch=check_label(test_data(i,:),trees(k));
        if ch==1 
            y(i)=k;
        end
    end
end
end

function label=check_label(example,tree)
if isempty(tree.kids)
    label=tree.class;
else
    attribute=tree.op;
    label=check_label(example,tree.kids{example(attribute)+1});
end
end
    