%%% Project Path planning in dynamic environment 
%%% 12/04/2021
%%% Rémi Cartert


function [obstacle_cell]=Obstacle_Detection(n_size,input_matrix,size_map,px,py,Obstacle_orientation,X_Obstacle,Y_Obstacle)

%%%%%%%%%%%%   input    %%%%%%

sz = [n_size n_size];
[row,col] = ind2sub(sz,input_matrix); %position in ROBOT Frame

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
nbr_obstacle_detected=0;
nb_block=0;
previous_is_a_block=0;
%row contains x_values in the agent frame
%col contains y_values in the agent frame


%%%% we'll considere that 2 block cell next to each other, are part of the same brick 
%%%% Regarding the map the case that 2 obstacles are in contact are rare


% I don't know exactly how configure the loop





for j=1:numel(col)
    for i=1:numel(row)
        PX_GF=px+row(i); % Position GLOBAL Frame
        PY_GF=py-col(j);

        if (input_map(PX_GF,PY_GF)==0)  %there is no block at that position, this position is free

        else                            % there is a block at that position

            if ((px+row(i)==size_map) || (py-col(j)==size_map)) %%%%%%%%%%%%%%%%%%%%%%%% Limit Wall
                index=index+1; %we decide that the index for the wall is always going to be 1;
                pos=[row(i) col(j)]; %the position in hte agent frame
                nb_block=nb_block+1; %every time we find a new block we had a new pose in the 3rd cell
                obstacle_cell{1,nbr_obstacle_detected+1}{1,2}{1,nb_block}=pos;
            end

            %Considering the obstacle of the Map Obst 1 goes along X axis
            %and the second one goes along Y axis
            if (X_Obstacle<=PX_GF && PX_GF<=X_Obstacle+Obstacle_orientation(nb_obstacles))
                
            end
            
    

            if (previous_is_a_block~=1)% So we have an block that belongs to a new obstacle
                nb_obstacles=nb_obstacles+1; %it will be stocked in a new cell
                index=index+1;
                obs{1,1}=index;
                obs{1}
                obstacle_cell{1,1}
            else
                nb_block=nb_block+1;%if there was a block        before we are on the same obstacle
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
end
