	clear;  
%%%%%%%%%%%%%%%%%%%
%Manuel Seet 15-04-2018
%{THIS SCRIPT IS FOR RUNNING THROUGH MULTIPLE PARTICIPANTS AT ONE SHOT
    %DELIVERABLES: (1) INDVL PSYCHOMETRIC CURVES PER BLOCK of 210 trials.
    %DELIVERABLES: (2) PNG COPIES OF FIGURES
    %DELIVERABLES: (3) PRINT PSEs in Excel Sheet
    
    %Original Study: Facial Expression Classification with EEG signals
    % 3 blocks = 3 * 210trials = 630 trials per subject
    % 7 conditions, graded from: Happy --- Neutral --- Angry 
%%%%%%%%%%%%%%%%%%%
    
    %Experimental Paramaters    
    paraGuess = [1, 0.5];
    resp_angry = 1;
    resp_happy = 2;
    totTrials = 30; %total trials per condition
    xAxis = [0.2 0.3 0.4 0.5 0.6 0.7 0.8]; %values on the axis
    nFaces = 7; %number of morphs
    
    %Data File details
    filename = 'MASTER_PSEs.xlsx';
    
    %participant id's
    participant = [99 98 3 97 96 95 94 93 92 91 89 88 87 86 85 84 83 82 81 80 78 77 76 73];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
excel_data = {'Participant No.','PSE Block 1','PSE Block 2','PSE Block 3','PSE All Blocks','SLOPE Block 1','SLOPE Block 2','SLOPE Block 3','SLOPE All Blocks'};

    for p = participant %Run through all the participants at once
        %Participant Details
        Partic = p;
        DocName1 = ['P',num2str(Partic),' - 1','.xlsx'];
        DocName2 = ['P',num2str(Partic),' - 2','.xlsx'];
        DocName3 = ['P',num2str(Partic),' - 3','.xlsx'];
        
        %Setting up data file reading parameters
        worksheet_no = 1;

        resp_column = 'AB';
        cond_column = 'R';
        start_row = '2';
        end_row = num2str((nFaces*totTrials)+1);

        resp_range = [resp_column,start_row,':',resp_column,end_row];
        cond_range = [cond_column,start_row,':',cond_column,end_row];
        
%         hand_cell = 'I2';

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%         %Handedness
%         hand = xlsread(DocName1,worksheet_no,'I2');
        
        %Reading Data file 1
        exp1 = xlsread(DocName1,worksheet_no,resp_range); %collate response data

        if resp_angry<resp_happy %converting angry = 1 and happy = 0
            rawResp1 = (resp_happy+resp_angry)-exp1-resp_angry;
        elseif resp_angry>resp_happy
            rawResp1 = exp1;
        end

        cond1 = xlsread(DocName1,worksheet_no,cond_range); %collate conditions
        rawCond1 = cond1;

        %Reading Data file 2
        exp2 = xlsread(DocName2,worksheet_no,resp_range); %collate response data

        if resp_angry<resp_happy %converting angry = 1 and happy = 0
            rawResp2 = (resp_happy+resp_angry)-exp2-resp_angry;
        elseif resp_angry>resp_happy
            rawResp2 = exp2;
        end

        cond2 = xlsread(DocName2,worksheet_no,cond_range); %collate conditions
        rawCond2 = cond2;

        %Reading Data file 3
        exp3 = xlsread(DocName3,worksheet_no,resp_range); %collate response data

        if resp_angry<resp_happy %converting angry = 1 and happy = 0
            rawResp3 = (resp_happy+resp_angry)-exp3-resp_angry;
        elseif resp_angry>resp_happy
            rawResp3 = exp3;
        end

        cond3 = xlsread(DocName3,worksheet_no,cond_range); %collate conditions
        rawCond3 = cond3;

        %Compile all 3 data files

        rawRespMat = [rawResp1 rawResp2 rawResp3];
        rawRespTot= rawRespMat(:);

        rawCondMat = [cond1  cond2  cond3];
        rawCondTot = rawCondMat(:);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %sort data
        for si = 1:nFaces % si is the index for test stimuli


            fracAngry1(si) = sum(rawResp1(rawCond1(:,1) == xAxis(si)))/(totTrials*resp_angry);

            fracAngry2(si) = sum(rawResp2(rawCond2(:,1) == xAxis(si)))/(totTrials*resp_angry);

            fracAngry3(si) = sum(rawResp3(rawCond3(:,1) == xAxis(si)))/(totTrials*resp_angry);  

            fracAngryTot(si) = sum(rawRespTot(rawCondTot(:,1) == xAxis(si)))/(3*totTrials*resp_angry);

        end

        %plot data

        figure;
        plot(xAxis, fracAngry1(1:nFaces),'go'); hold on;
        plot(xAxis, fracAngry2(1:nFaces),'ro'); hold on;
        plot(xAxis, fracAngry3(1:nFaces),'bo');hold on;
        plot(xAxis, fracAngryTot(1:nFaces),'k*');hold on;

        %Fit the Curves and draw each curve on the graph
        paraFit1 = lsqcurvefit(@sigmoid, paraGuess, xAxis, fracAngry1);
        x = linspace(0, 1, 100);
        y = sigmoid(paraFit1, x);
        H = plot(x, y,'Color',[0 .5 0]); hold on;

        paraFit2 = lsqcurvefit(@sigmoid, paraGuess, xAxis, fracAngry2);
        x = linspace(0, 1, 100);
        y = sigmoid(paraFit2, x);
        H = plot(x, y,'r'); hold on;

        paraFit3 = lsqcurvefit(@sigmoid, paraGuess, xAxis, fracAngry3);
        x = linspace(0, 1, 100);
        y = sigmoid(paraFit3, x);
        H = plot(x, y,'b'); hold on;

        paraFitTot = lsqcurvefit(@sigmoid, paraGuess, xAxis, fracAngryTot);
        x = linspace(0, 1, 100);
        y = sigmoid(paraFitTot, x);
        H = plot(x, y,'k'); hold on;
        
        %Add participant title
        title(['P',num2str(Partic)],'FontSize',14);
        
        %Print the PSEs
        strPSE1 = ['PSE_1 = ',num2str(paraFit1(2))];
        text(0.65,0.4,strPSE1,'HorizontalAlignment','left','FontSize',12,'Color',[0 .5 0]);

        strPSE2 = ['PSE_2 = ',num2str(paraFit2(2))];
        text(0.65,0.3,strPSE2,'HorizontalAlignment','left','FontSize',12,'Color','r');

        strPSE3 = ['PSE_3 = ',num2str(paraFit3(2))];
        text(0.65,0.2,strPSE3,'HorizontalAlignment','left','FontSize',12,'Color','b');

        strPSETot = ['PSE_{All} = ',num2str(paraFitTot(2))];
        text(0.65,0.1,strPSETot,'HorizontalAlignment','left','FontSize',12,'Color','k','LineWidth', 5);
        
        %SAVE THE FIGURES
        saveas(gcf,['P',num2str(Partic),'.png']);

        %APPEND EXCEL DATA
        results = {Partic, paraFit1(2), paraFit2(2), paraFit3(2), paraFitTot(2),paraFit1(1), paraFit2(1), paraFit3(1), paraFitTot(1)};
        excel_data = [excel_data; results];    
        
    end
    
    %Display final PSEs for all participants
    excel_data;
    
    %Save to EXCEL file
    xlswrite(filename,excel_data,1,'A1');
    
    disp('All Done!');