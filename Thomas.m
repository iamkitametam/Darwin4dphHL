% Thomas algorithm: 
% Gaussian eleimination for tridiagonal linear systems
% d = main diag,  l = lower diag, 
% u = upper diag, f = right-hand side vector
function x = Thomas(l,d,u,f)

n=length(f);
l=[0 l];

for i=2:n
    d(i)=d(i)-u(i-1)*l(i)/d(i-1);
    f(i)=f(i)-f(i-1)*l(i)/d(i-1);
end

% backward solution
x(n)=f(n)/d(n);
for i=n-1:-1:1
    x(i)=(f(i)-u(i)*x(i+1))/d(i);
end