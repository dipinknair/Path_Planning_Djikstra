%%% Project Path planning in dynamic environment 
%%% 12/04/2021
%%% Rémi Cartert

clear;
close all;
clc;
%%

%%%%%%%%%%%%   input    %%%%%%
ind = [3 4 5 6]; % input
size_matrix=30;
sz = [size_matrix size_matrix];
[row,col] = ind2sub(sz,ind);

%%%%%%%%%%%%   processing   %%%%%%
%%%%%% init output_cell %%%%%

%%%% obstacle_cell{{obs1},{obs2},{obs3},...} %%%% all obstacle in robot vison
%%%% obs1={index,{pos},vel} %%%%
%%%% pos={{[X1 Y1],[X2 Y2], ...} %%%% all position of blocks in robot frame 
pos={};
index=0;
vel=1; %vel of the obstacles are the same
obs={index,pos,vel};
obstacle_cell={obs};
nb_obstacles=0;
nb_block=0;
previous_is_a_block=0;
%row contains x_values in the agent frame
%col contains y_values in the agent frame


%%%% we'll considere that 2 block cell next to each other, are part of the same brick 
%%%% Regarding the map the case that 2 obstacles are in contact are rare


% I don't know exactly how configure the loop
for i=1:numel(row)
        if (walls(row(i)+px,col(i)+py)==1) % there is a block at that position
            if (previous_is_a_block~=1)% So we have an block that belongs to a new obstacle
                nb_obstacles=nb_obstacles+1; %it will be stocked in a new cell
                index=index+1;
                obs{1,1}=index;
            else
                nb_block=nb_block+1;%if there was a block before we are on the same obstacle
            end
            X=row(i);
            Y=col(i);
            pos{1,nb_block}=[X Y];
            obs{1,2}=pos;
            obstacle_cell{1,nb_obstacles}=obs;
            previous_is_a_block=1;
        else 
            previous_is_a_block=0;
        end
end
