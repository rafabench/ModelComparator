function compare_objective(model1, model2, lists, openfile, tol, compare_one_by_one)
    printconstraint = true
    equals_names,equals_names_index_1,equals_names_index_2,diffs2,diffs2_index,diffs1,diffs1_index = lists
    
    if MOI.get(model1,MOI.ObjectiveSense()) == MOI.get(model2,MOI.ObjectiveSense())
        #write(openfile, "EQUAL SENSE: ", string(MOI.get(model2,MOI.ObjectiveSense())),"\n")
        nothing
    else
        write(openfile, "\tUNIQUE SENSE MODEL 1: ", string(MOI.get(model2,MOI.ObjectiveSense())),"\n")
        write(openfile, "\tUNIQUE SENSE MODEL 2: ", string(MOI.get(model2,MOI.ObjectiveSense())),"\n")
    end
    
    n_var_1 = MOI.get(model1,MOI.NumberOfVariables())
    n_var_2 = MOI.get(model2,MOI.NumberOfVariables())
    attr1 = MOI.get(model1, MOI.ObjectiveFunctionType())
    attr2 = MOI.get(model2, MOI.ObjectiveFunctionType())
    objective1 = MOI.get(model1,MOI.ObjectiveFunction{attr1}())
    objective2 = MOI.get(model2,MOI.ObjectiveFunction{attr2}())
    
    if attr1 != attr2
        write(openfile, "\tOBJECTIVE TYPES ARE DIFFERENT:","\n")
        write(openfile, "\t\tMODEL 1: ",attr1,"\n")
        write(openfile, "\t\tMODEL 2: ",attr2,"\n")
    else
        compare_expressions(objective1,objective2,model1,model2,openfile,tol,printconstraint, "OBJECTIVE", compare_one_by_one, false)
    end
end