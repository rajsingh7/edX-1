def getSheetLength(sheet):
    size = 1
    while(True):
        if(Cell(sheet,size,"A").value == None):
            return size-1
        else:
            size = size+1
            
num_movie_actors = getSheetLength("Movie_Actor")
num_actors = getSheetLength("Actor")

def AllSteps(m,step):
    List = []
    source_column = step*2+1
    for i in range(2, num_movie_actors+1):
        if Cell(i,2).value == m:
            List.append(Cell(i,source_column).value)
    return List

def NextStep(steps):
    for s in steps:
        if s != "-":
            return s + 1
    return "-"    
    

def SolveStep(step):
    new_column = 2 + step * 2
    Cell(1,new_column).value = "Step from Movie "+str(step)
    Cell(1,new_column).font.bold = True
    for i in range (2,num_movie_actors+1):
        Cell(i,new_column).value = NextStep(AllSteps(Cell(i,2).value,step))

def getMovieActorBaconNum(actor,step):
    actor_nums = []
    source_column = 2+(step*2)
    for i in range(2,num_movie_actors+1):
        if(Cell("Movie_Actor",i,"A").value==actor):
            actor_nums.append(Cell("Movie_Actor",i,source_column).value)
    if all(actor_num == "-" for actor_num in actor_nums):
        return "-"
    else:
        return min(actor_nums)

def actorImportBacon(step):
    step_column = step+2
    Cell("Actor",1,step_column).value = "Step "+str(step+1)
    Cell("Actor",1,step_column).font.bold = True
    for i in range(2,num_actors+1):
        bacon_to_import = getMovieActorBaconNum(Cell("Actor",i,"A").value,step)
        previous_step =Cell("Actor",i,step_column-1).value
        if(previous_step!="-" and previous_step<bacon_to_import):
            Cell("Actor",i,step_column).value = previous_step        
        else:
            Cell("Actor",i,step_column).value = bacon_to_import



step_to_solve = 1
SolveStep(step_to_solve)
actorImportBacon(step_to_solve)
