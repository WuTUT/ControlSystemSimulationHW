function uo=nonlinearlink(u,link)
%link =cell(link_number,4)
%link(i,:) = {linktype,c1,h0,h1}
%linktype is character array: fenduan,jianxie,siqu,zhihuan,siquzhihuan,none
%use [] if h0 or h1 is not set
%{fenduan,c2,h0,h1}
%{jianxie,c1,[],[]}
%{siqu,c1,[],h1}
%{zhihuan,c1,[],h1}
%{siquzhihuan,c1,h0,h1}
uo=zeros(size(u));
for i=1:size(u,1)
    switch cell2mat(link(i,1))
        case 'fenduan'
            uo(i,1)=fenduan(u(i,1),cell2mat(link(i,2)),cell2mat(link(i,3)),cell2mat(link(i,4)));
        case 'jianxie'
            uo(i,1)=jianxie(u(i,1),cell2mat(link(i,2)),i);
        case 'siqu'
            uo(i,1)=siqu(u(i,1),cell2mat(link(i,2)),cell2mat(link(i,4)));
        case 'zhihuan'
            uo(i,1)=zhihuan(u(i,1),cell2mat(link(i,2)),cell2mat(link(i,4)),i);
        case 'siquzhihuan'
            uo(i,1)=siquzhihuan(u(i,1),cell2mat(link(i,2)),cell2mat(link(i,3)),cell2mat(link(i,4)),i);
        case 'none'
            uo(i,1)=u(i,1);
        otherwise
            error('Wrong link type input(linktype is character array: fenduan,jianxie,siqu,zhihuan,siquzhihuan,none)');
    end
end
end
function uo=fenduan(ui,c1,h0,h1)
if ui<-c1
    uo=-(h0*c1+h1*(-c1-ui));
else
    if ui>c1
        uo=h0*c1+h1*(-c1+ui);
    else
        uo=h0*ui;
    end
end
end
function uo=jianxie(ui,c1,i)
global uolast;
global uilast;
if ui>uilast(i,1)&&uolast(i,1)<ui-c1
    uo=ui-c1;
else
    if ui<uilast(i,1)&&uolast(i,1)>ui+c1
        uo=ui+c1;
    else
        uo=uolast(i,1);
    end
end
uolast(i,1)=uo;
uilast(i,1)=ui;
end
function uo=siqu(ui,c1,h1)
if abs(ui)>=h1
    if ui>=h1
        uo=c1;
    else
        uo=-c1;
    end    
else
    uo=0;
end
end
function uo=zhihuan(ui,c1,h1,i)
global uolast;
global uilast;
if ui>uilast(i,1)&&ui>=h1
    uo=c1;
else
    if ui<uilast(i,1)&&ui<=-h1
        uo=-c1;
    else
        uo=uolast(i,1);
    end
end
uolast(i,1)=uo;
uilast(i,1)=ui;
end
function uo=siquzhihuan(ui,c1,h0,h1,i)
global uolast;
global uilast;
if abs(ui)<=h0
    uo=0;
else
    if ui>=h1
        uo=c1;
    else
        if ui<=-h1
            uo=-c1;
        else
            uo=uolast(i,1);
        end
    end
end
uolast(i,1)=uo;
uilast(i,1)=ui;
end
    
    
        