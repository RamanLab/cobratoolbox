function configEnvVars(printLevel)

    global GUROBI_PATH;
    global ILOG_CPLEX_PATH;
    global TOMLAB_PATH;
    global MOSEK_PATH;
    global ENV_VARS;

    if nargin < 1
        printLevel = 0;
    end

    if exist('ENV_VARS.STATUS', 'var') == 1 || ENV_VARS.STATUS == 0
        solverPaths = {};
        solverPaths{1, 1} = 'ILOG_CPLEX_PATH';
        solverPaths{1, 2} = {'/Applications/IBM/ILOG/CPLEX_Studio1262', '/Applications/IBM/ILOG/CPLEX_Studio1263', '/Applications/IBM/ILOG/CPLEX_Studio127', '/Applications/IBM/ILOG/CPLEX_Studio1271', ...
                            '~/Applications/IBM/ILOG/CPLEX_Studio1262', '~/Applications/IBM/ILOG/CPLEX_Studio1263', '~/Applications/IBM/ILOG/CPLEX_Studio127', '~/Applications/IBM/ILOG/CPLEX_Studio1271', ...
                            '/opt/ibm/ILOG/CPLEX_Studio1262', '/opt/ibm/ILOG/CPLEX_Studio1263', '/opt/ibm/ILOG/CPLEX_Studio127', '/opt/ibm/ILOG/CPLEX_Studio1271' ...
                            'C:\Program Files\IBM\ILOG\CPLEX_Studio1262', 'C:\Program Files\IBM\ILOG\CPLEX_Studio1263', 'C:\Program Files\IBM\ILOG\CPLEX_Studio127', 'C:\Program Files\IBM\ILOG\CPLEX_Studio1271'};
        solverPaths{1, 3} = 'CPLEX_Studio'; % alias
        solverPaths{2, 1} = 'GUROBI_PATH';
        solverPaths{2, 2} = {'/Library/gurobi600', '/Library/gurobi650', '/Library/gurobi70', '/Library/gurobi700', '/Library/gurobi701', '/Library/gurobi702', ...
                            '~/Library/gurobi600', '~/Library/gurobi650', '~/Library/gurobi70', '~/Library/gurobi700', '~/Library/gurobi701', '~/Library/gurobi702', ...
                            '/opt/gurobi600', '/opt/gurobi650', '/opt/gurobi70', '/opt/gurobi700', '/opt/gurobi701', '/opt/gurobi702', ...
                            'C:\gurobi600', 'C:\gurobi650', 'C:\gurobi70', 'C:\gurobi700', 'C:\gurobi701', 'C:\gurobi702'};
        solverPaths{2, 3} = 'gurobi'; % alias
        solverPaths{3, 1} = 'TOMLAB_PATH';
        solverPaths{3, 2} = {'/opt/tomlab', 'C:\tomlab', 'C:\Program Files\tomlab', 'C:\Program Files (x86)\tomlab', '/Applications/tomlab'};
        solverPaths{3, 3} = 'tomlab'; % alias
        solverPaths{4, 1} = 'MOSEK_PATH';
        solverPaths{4, 2} = {'/opt/mosek/7/', '/opt/mosek/8/', '/Applications/mosek/7', '/Applications/mosek/8', 'C:\Program Files\Mosek\7', 'C:\Program Files\Mosek\8'};
        solverPaths{4, 3} = 'mosek'; % alias

        isOnPath = false;

        for k = 1:length(solverPaths)

            method = '----';

            % try retrieving the solver path from the environment variables
            eval([solverPaths{k, 1}, ' = getenv(''', solverPaths{k, 1} , ''');'])
            if ~isempty(eval(solverPaths{k, 1}))
                method = '*---';
            end

            % loop through the list of possible directories
            possibleDir = '';
            tmpSolverPath = solverPaths{k, 2};
            for i = 1:length(solverPaths{k, 2})
                if exist(tmpSolverPath{i}, 'dir') == 7
                    possibleDir = tmpSolverPath{i};
                end;
            end

            if isempty(eval(solverPaths{k, 1}))
                % check if the solver is already on the MATLAB path
                isOnPath = ~isempty(strfind(lower(path), lower(possibleDir)));

                % find the index of the most recently added solver path
                tmp = path;
                if isunix
                    tmpS = strsplit(tmp, ':');
                else
                    tmpS = strsplit(tmp, ';');
                end

                % build reqular expression to check for the solver
                extraRE = '';
                if k == 2  % gurobi
                    extraRE = '\w'; % any word, alphanumeric and underscore
                end
                idCell = regexp(tmpS, ['/(', solverPaths{k, 3}, ')', extraRE, '+']);
                higherLevelIndex = 0;
                for i = 1:length(idCell)
                    if ~isempty(idCell{i})
                        higherLevelIndex = i;
                        break;
                    end
                end

                % solver is on the path and at a standard location
                if isOnPath
                    eval([solverPaths{k, 1}, ' = ''', possibleDir, ''';']);
                    method = '-*--';

                % solver is on path but at a non-standard location and may not be compatible
                elseif higherLevelIndex > 0 && higherLevelIndex < length(idCell)
                    eval([solverPaths{k, 1}, ' = ''', tmpS{higherLevelIndex}, ''';']);
                    method = '--*-';
                end
            end

            % solver is not already on the path and the environment variable is not set, but the directory exists
            if isempty(eval(solverPaths{k, 1}))
                if ~isempty(possibleDir)
                    eval([solverPaths{k, 1}, ' = ''', possibleDir, ''';']);
                    method = '---*';
                end
            end

            % if the solver variable is still empty, then give instructions on how to proceed
            if isempty(eval(solverPaths{k, 1}))
                if printLevel > 0
                    solversLink = 'https://git.io/v92Vi'; % curl -i https://git.io -F "url=https://github.com/opencobra/cobratoolbox/blob/master/.github/SOLVERS.md"
                    if usejava('desktop')
                        solversLink = ['<a href=\"', solversLink, '\">instructions</a>'];
                    end
                    fprintf(['   - [', method, '] ', solverPaths{k, 1}, ' :  --> set this path manually after installing the solver ( see ', solversLink, ' )\n' ]);
                end
            else
                if printLevel > 0
                    fprintf(['   - [', method, '] ', solverPaths{k, 1}, ': ', strrep(eval(solverPaths{k, 1}), '\', '\\'), '\n' ]);
                end
                ENV_VARS.STATUS = 1;
            end
        end
    end
end
