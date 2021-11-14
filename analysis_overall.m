	clear;  
%%%%%%%%%%%%%%%%%%%
%Manuel Seet 27-04-2018
%{THIS SCRIPT IS FOR RUNNING THROUGH MULTIPLE PARTICIPANTS AT ONE SHOT
    %DELIVERABLES: (1) OVERALL PSYCHOMETRIC CURVES PER BLOCK of 210 trials.
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
    participant = [99 98 97 96 95 94 93 92 91 90 89 88 87 86 3 4];
    N = length(participant)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%excel_data = {'Participant No.','PSE Block 1','PSE Block 2','PSE Block 3','PSE All Blocks'};

 M = cell(N, 1);

    for i = 1:N
        p = participant(i); %Run through all the participants at once
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
        M1{i}(si) = sum(rawResp1(rawCond1(:,1) == xAxis(si)))/(totTrials*resp_angry);
        M2{i}(si) = sum(rawResp2(rawCond2(:,1) == xAxis(si)))/(totTrials*resp_angry);
        M3{i}(si) = sum(rawResp3(rawCond3(:,1) == xAxis(si)))/(totTrials*resp_angry);  
        MTot{i}(si) = sum(rawRespTot(rawCondTot(:,1) == xAxis(si)))/(3*totTrials*resp_angry);
        end

        %plot data
    end
    
average1 = [];
average2 = [];
average3 = [];

%Calculate the Average of the rows of the cell array
%for block 1
for e = 1:7 %for each face
   single_face = [];
   for i = 1:N %for all subjects
    single_face(i)=(M1{i}(e));
   end
 average1(e) = mean(single_face);
end

%for block 2
for e = 1:7 %for each face
   single_face = [];
   for i = 1:N %for all subjects
    single_face(i)=(M2{i}(e));
   end
 average2(e) = mean(single_face);
end

%for block 3
for e = 1:7 %for each face
   single_face = [];
   for i = 1:N %for all subjects
    single_face(i)=(M3{i}(e));
   end
 average3(e) = mean(single_face);
end

%for block all
for e = 1:7 %for each face
   single_face = [];
   for i = 1:N %for all subjects
    single_face(i)=(MTot{i}(e));
   end
 averageTot(e) = mean(single_face);
end

% 
% %for loop to plot the individual points and plot the curve for each subject
%     for i = 1:18
%         color = [rand() rand() rand()];
%         plot(xAxis, M{i}(1:nFaces),'.','Color', color, 'MarkerSize',3); hold on;
% 
%         %Fit the Curves and draw each curve on the graph
%         paraFit1 = lsqcurvefit(@sigmoid, paraGuess, xAxis, M{i});
%         x = linspace(0, 1, 100);
%         y = sigmoid(paraFit1, x);
%         H = plot(x, y, 'Color', color); hold on;
%                 
%         %Add participant title
%         %title(['P',num2str(Partic)],'FontSize',14);
%         
%         %Print the PSEs
%         %{
%         strPSE1 = ['PSE_1 = ',num2str(paraFit1(2))];
%         text(0.65,0.4,strPSE1,'HorizontalAlignment','left','FontSize',12,'Color',[0 .5 0]);
%         strPSE2 = ['PSE_2 = ',num2str(paraFit2(2))];
%         text(0.65,0.3,strPSE2,'HorizontalAlignment','left','FontSize',12,'Color','r');
%         strPSE3 = ['PSE_3 = ',num2str(paraFit3(2))];
%         text(0.65,0.2,strPSE3,'HorizontalAlignment','left','FontSize',12,'Color','b');
%         
%         strPSETot = ['PSE_{All} = ',num2str(paraFitTot(2))];
%         text(0.65,0.1,strPSETot,'HorizontalAlignment','left','FontSize',12,'Color','k','LineWidth', 5);
%         
% 
%         
%         %APPEND EXCEL DATA
%         results = {Partic, paraFit1(2), paraFit2(2), paraFit3(2), paraFitTot(2)};
%         excel_data = [excel_data; results];    
%         %}
%     end
    
    
%         %%%%% Plot Average Psychometric Curve %%%%%%%
%         plot(xAxis, average(1:nFaces),'ok','MarkerFaceColor',[0 0 0],'MarkerSize',4); hold on;
%         %Fit the Curves and draw each curve on the graph
%         paraFit1 = lsqcurvefit(@sigmoid, paraGuess, xAxis, average1);
%         x = linspace(0, 1, 100);
%         y = sigmoid(paraFit1, x);
%         H = plot(x, y,'Color',[0 0 0],'LineWidth',3); hold on;

        %%%% AVERAGE OFEACH Block%%%%%%%
        figure;
        
        plot(xAxis, average1(1:nFaces),'go'); hold on;
        plot(xAxis, average2(1:nFaces),'ro'); hold on;
        plot(xAxis, average3(1:nFaces),'bo');hold on;
        plot(xAxis, averageTot(1:nFaces),'ok','MarkerFaceColor',[0 0 0],'MarkerSize',5);hold on;

        
        %Fit the Curves and draw each curve on the graph
        paraFit1 = lsqcurvefit(@sigmoid, paraGuess, xAxis, average1);
        x = linspace(0, 1, 100);
        y = sigmoid(paraFit1, x);
        H = plot(x, y,'Color',[0 .5 0]); hold on;

        paraFit2 = lsqcurvefit(@sigmoid, paraGuess, xAxis, average2);
        x = linspace(0, 1, 100);
        y = sigmoid(paraFit2, x);
        H = plot(x, y,'r'); hold on;

        paraFit3 = lsqcurvefit(@sigmoid, paraGuess, xAxis, average3);
        x = linspace(0, 1, 100);
        y = sigmoid(paraFit3, x);
        H = plot(x, y,'b'); hold on;

        paraFitTot = lsqcurvefit(@sigmoid, paraGuess, xAxis, averageTot);
        x = linspace(0, 1, 100);
        y = sigmoid(paraFitTot, x);
        H = plot(x, y,'k', 'LineWidth',2); hold on;
 

        
        
        %Print the PSEs
        
        strPSE1 = ['PSE_1 = ',num2str(paraFit1(2))];
        text(0.65,0.4,strPSE1,'HorizontalAlignment','left','FontSize',12,'Color','g');
        strPSE2 = ['PSE_2 = ',num2str(paraFit2(2))];
        text(0.65,0.3,strPSE2,'HorizontalAlignment','left','FontSize',12,'Color','r');
        strPSE3 = ['PSE_3 = ',num2str(paraFit3(2))];
        text(0.65,0.2,strPSE3,'HorizontalAlignment','left','FontSize',12,'Color','b');
        
        strPSETot = ['PSE_{All} = ',num2str(paraFitTot(2))];
        text(0.65,0.1,strPSETot,'HorizontalAlignment','left','FontSize',12,'Color','k','LineWidth', 5);
        
        %Vertical line for PSEs
        line([1 1]*num2str(paraFit1(2)), ylim, '--g');
        line([1 1]*num2str(paraFit2(2)), ylim, '--r');
        line([1 1]*num2str(paraFit3(2)), ylim, '--b');
        
        line([1 1]*num2str(paraFitTot(2)), ylim, '--k');
        
        
        %SAVE THE FIGURES
        %saveas(gcf,['AverageOnly_black.fig']);
        %saveas(gcf,['IndividualS&Average_black.fig']);
        %saveas(gcf,['IndividualsOnly.fig']);
        
        
        
    %{
    %Display final PSEs for all participants
    excel_data
    
    %Save to EXCEL file
    xlswrite(filename,excel_data,1,'A1')
    
    disp('All Done!')
    %}