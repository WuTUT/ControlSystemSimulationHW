function varargout=StateTransitionMethod(A,B,T,method)
f=expm(A*T);
syms x
fmt=expm(A*(T-x))*B;
fm=int(fmt,[0 T]);
fmt2=x*expm(A*(T-x))*B;
fm2=int(fmt2,[0 T]);
if strcmp(method,'ZOH')
    varargout{1}=f;
    varargout{2}=fm;
else
    if strcmp(method,'TriangleHolder')
        varargout{1}=f;
        varargout{2}=fm;
        varargout{3}=fm2;
    else
        error('Wrong method input');
    end
end

        