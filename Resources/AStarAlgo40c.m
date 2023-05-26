function times = AStarAlgo40c(neighbors)
% A-Star Algorithm in an occupancy grid
clc; close all;
LoadMap % map of obstabcles and available space
%Start Positions
StartX=80;
StartY=110;
%End Positions
TargetX=5;
TargetY=87;
%Height and width of matrix
[Height,Width]=size(MAP);
%Matrix keeping track of G-scores
GScore=zeros(Height,Width);
%Matrix keeping track of F-scores (only open list)
FScore=inf(Height,Width);
%Heuristic matrix
Hn=zeros(Height,Width);
%Matrix keeping of open grid cells
OpenSet=zeros(Height,Width);
%Matrix keeping track of closed grid cells
ClosedSet=zeros(Height,Width);
%Adding object-cells to closed matrix
ClosedSet(MAP==1)=1;
%Matrix keeping track of X position of parent
ParentX=zeros(Height,Width);
%Matrix keeping track of Y position of parent
ParentY=zeros(Height,Width);
%%% Setting up matrices representing neighboors to be investigated

NeighborCheck=int8(neighbors);
[row,col]=find(NeighborCheck==1);
Neighbors=[row col]-5;
N_Neighbors=size(col,1);

% timing code
t = 0;
times = [];
for ii = 1:100
% Creating Heuristic-matrix based on distance to nearest goal node
for k=1:size(MAP,1)
    for j=1:size(MAP,2)
        if MAP(k,j)==0
            % Difference of coordinates, finding distance
            Hn(k,j)=norm([TargetX TargetY]-[k j]);
        end
    end
end

%Initializign start node with FValue and opening first node.
FScore(StartY,StartX) = Hn(StartY,StartX);
OpenSet(StartY,StartX) = 1; RECONSTRUCTPATH=1;

    while 1==1 %Code will break when path found or when no path exist
    tic %starting stopwatch timer
    MINopenFSCORE=min(min(FScore));
    if MINopenFSCORE==inf;
        %Failuere!
        OptimalPath=[inf];
        RECONSTRUCTPATH=0;
        break
    end
    
    [CurrentX,CurrentY]=find(FScore==MINopenFSCORE);
    CurrentX=CurrentX(1);
    CurrentY=CurrentY(1);
    FScore(CurrentX,CurrentY)=inf;
    
    if CurrentX==TargetX && CurrentY==TargetY
        break
    end
    
    for p=1:N_Neighbors
        i=Neighbors(p,1); %X
        j=Neighbors(p,2); %Y
        % Checking if neighbor is inside or outside the MAP
        % the neighbor is outside the MAP, ignore it,
        % and move to next neighbor (use continue)
        if CurrentX+i<1 || CurrentX+i>Height ...
                || CurrentY+j<1 || CurrentY+j>Width
            continue
        end
        % Now checking obstacle
        Flag=1;
        if (ClosedSet(CurrentX+i,CurrentY+j)==0) %Neighbor is open to move
            if (abs(i)>1||abs(j)>1)
                JumpCellsi=(1:abs(i))*sign(i);
                JumpCellsj=(1:abs(j))*sign(j);
                for Ki=1:length(JumpCellsi)
                    for Kj=1:length(JumpCellsj)
                        if (MAP(CurrentX+JumpCellsi(Ki),...
                                CurrentY+JumpCellsj(Kj))==1)
                            Flag=0;
                        end
                    end
                end
            end
            %End of checking that the path does not pass an object
            if Flag==1;
                Dist_Curr_Neighb=sqrt(i^2+j^2);
                Tentative_GScore = GScore(CurrentX,CurrentY)+Dist_Curr_Neighb;
                if OpenSet(CurrentX+i,CurrentY+j)==0
                    OpenSet(CurrentX+i,CurrentY+j)=1;
                elseif GScore(CurrentX+i,CurrentY+j) < Tentative_GScore
                    continue
                end
                % This path to neighbor is better than any previous one; record it!
                ParentX(CurrentX+i,CurrentY+j)=CurrentX;
                ParentY(CurrentX+i,CurrentY+j)=CurrentY;
                GScore(CurrentX+i,CurrentY+j)=Tentative_GScore;
                FScore(CurrentX+i,CurrentY+j)= ...
                    GScore(CurrentX+i,CurrentY+j)...
                    + Hn(CurrentX+i,CurrentY+j);
            end
        end
    end
    t = t + toc;
    end
    times = [times t];
    t = 0;
end

if RECONSTRUCTPATH
    k=1; OptimalPath(1,:)=[CurrentX CurrentY];
    while 1==1
        k=k+1;
        CurrentYDummy=ParentY(CurrentX,CurrentY);
        if CurrentYDummy==0; break; end
        CurrentX=ParentX(CurrentX,CurrentY);
        CurrentY=CurrentYDummy;
        OptimalPath(k,:)=[CurrentX CurrentY];
        if CurrentX==StartX && CurrentY==StartY
            break
        end
    end
end
r=size(NeighborCheck,1);
figure; subplot 121; imagesc(NeighborCheck);colormap(flipud(gray));
axis([0 r+1 0 r+1]);title(['No of Neighbors = ' num2str(N_Neighbors)])
axis square; set(gca,'fontsize',14);
if size(OptimalPath,2)>1
    subplot 122;imagesc(MAP);colormap(flipud(gray)); hold on
    plot(OptimalPath(:,2),OptimalPath(:,1),'b','linewidth',3)
    plot(OptimalPath(1,2),OptimalPath(1,1),'o',...
        'color','y','markerfacecolor','r','markersize',10,'linewidth',3)
    plot(OptimalPath(end,2),OptimalPath(end,1),'o',...
        'color','r','markerfacecolor','y','markersize',10,'linewidth',3)
    legend('Path','Goal','Start','Location','Best');
    axis square; set(gca,'fontsize',14);grid
    title('Optimal Path')
else
    pause(1);
    h=msgbox('Sorry, No path exists to the Target!','warn');
    uiwait(h,5);
end
