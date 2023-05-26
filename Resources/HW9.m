% Neighbor Matrices
n4 = [ ...
      0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0;
      0 0 0 0 1 0 0 0 0;
      0 0 0 1 0 1 0 0 0;
      0 0 0 0 1 0 0 0 0;
      0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0];
n8 = [ ...
      0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0;
      0 0 0 1 1 1 0 0 0;
      0 0 0 1 0 1 0 0 0;
      0 0 0 1 1 1 0 0 0;
      0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0];
n16 = [ ...
       0 0 0 0 0 0 0 0 0
       0 0 0 0 0 0 0 0 0;
       0 0 0 1 0 1 0 0 0;
       0 0 1 1 1 1 1 0 0;
       0 0 0 1 0 1 0 0 0;
       0 0 1 1 1 1 1 0 0;
       0 0 0 1 0 1 0 0 0;
       0 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 0 0 0];
n40 = [ ...
       0 0 0 0 0 0 0 0 0;
       0 1 1 1 0 1 1 1 0;
       0 1 1 1 0 1 1 1 0;
       0 1 1 1 1 1 1 1 0;
       0 0 0 1 0 1 0 0 0;
       0 1 1 1 1 1 1 1 0;
       0 1 1 1 0 1 1 1 0;
       0 1 1 1 0 1 1 1 0;
       0 0 0 0 0 0 0 0 0];
n68 = [
       1 1 1 1 0 1 1 1 1;
       1 1 1 1 0 1 1 1 1;
       1 1 1 1 0 1 1 1 1;
       1 1 1 1 1 1 1 1 1;
       0 0 0 1 0 1 0 0 0;
       1 1 1 1 1 1 1 1 1;
       1 1 1 1 0 1 1 1 1;
       1 1 1 1 0 1 1 1 1;
       1 1 1 1 0 1 1 1 1];

times4 = AStarAlgo40c(n4);
times8 = AStarAlgo40c(n8);
times16 = AStarAlgo40c(n16);
times40 = AStarAlgo40c(n40);
times68 = AStarAlgo40c(n68);

% individual plot generation
figure; hold on
plot(times4,'-+','LineWidth', 1)
plot(times8,'-o','LineWidth', 1)
plot(times16,'-*','LineWidth', 1)
plot(times40,'-.','LineWidth', 1)
plot(times68,'-s','LineWidth', 1)
ylim([0 2.5])
title('Run Times Over 100 Iterations','FontSize', 15)
xlabel('Iteration','FontSize', 15)
ylabel('Run Time','FontSize', 15)
av4 = mean(times4)
av8 = mean(times8)
av16 = mean(times16)
av40 = mean(times40)
av68 = mean(times68)
str4 = num2str(av4)
str8 = num2str(av8)
str16 = num2str(av16)
str40 = num2str(av40)
str68 = num2str(av68)
legend('Neighbors = 4','Neighbors = 8','Neighbors = 16','Neighbors = 40','Neighbors = 68','FontSize',12,'Location','Best')
% yline(mean(times68),':',['Avg. Run Time = ',str,' s'],'LineWidth',2,'LabelHorizontalAlignment','center','LabelVerticalAlignment','bottom','FontSize', 14)

