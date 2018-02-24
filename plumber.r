# plumber.R
library("ggpubr",warn.conflicts = FALSE)
library("dplyr",warn.conflicts = FALSE)
library("lubridate",warn.conflicts = FALSE)
library("gridExtra",warn.conflicts = FALSE)
library('ggplot2',warn.conflicts = FALSE)
library("jsonlite")
#install.packages("tidyr")
library("tidyr",warn.conflicts = FALSE)


#' @filter cors
cors <- function(res) {
  res$setHeader("Access-Control-Allow-Origin", "*")
  plumber::forward()
}


#' dashboardcharts endpoint
#' @param dataset1 The first dataset
#' @param dataset2 The second dataset
#' @param dataset3 The third dataset
#' @param dataset4 The fourth dataset
#' @param dataset5 The fifth dataset
#' @param dataset6 The sixth dataset
#' @param dataset7 The seventh dataset
#' @param dataset8 The eigth dataset
#' @param dataset9 The ninth dataset
#' @post /dashboardcharts
#' @png (width = 1000, height = 1000)
function(dataset1,
         dataset2,
         dataset3,
         dataset4,
         dataset5,
         dataset6,
         dataset7,
         dataset8,
         dataset9) {
  options(scipen=999)
  conv <- as.data.frame(dataset1) #activeenergyburned
  conv2 <- as.data.frame(dataset2) #deepsleep
  conv3 <- as.data.frame(dataset3) #flightsclimbed
  conv4 <- as.data.frame(dataset4) #heartrate
  conv5 <- as.data.frame(dataset5) #sleep
  conv6 <- as.data.frame(dataset6) #sleepheartrate
  conv7 <- as.data.frame(dataset7) #stepcounter
  conv8 <- as.data.frame(dataset8) #walkingrunningdistance
  conv9 <- as.data.frame(dataset9) #userinput

  View(conv9)

  
  df1 <- sumtotal(conv, '1 day') #activeenergyburned
  df2 <- meantotal(conv2, '1 day') #deepsleep
  df3 <- sumtotal(conv3, '1 day') #flightsclimbed
  df4 <- meantotal(conv4, '1 day') #heartrate
  df5 <- meantotal(conv5, '1 day') #sleep
  df6 <- meantotal(conv6, '1 day') #sleepheartrate
  df7 <- sumtotal(conv7, '1 day') #stepcounter
  df8 <- sumtotal(conv8, '1 day') #walkingrunningdistance
  
  View(df1)
  View(df2)
  View(df3)
  View(df4)
  View(df5)
  View(df6)
  View(df7)
  View(df8)

  df10 <- df1 %>%
    select(total, hour) %>%
    ggplot(aes(x=hour, y=total))+
    geom_bar(stat="identity", fill = "#FF6666", alpha=0.7) +
    xlab("Date") +
    ylab("Active Energy Burned")
  
  df20 <- df2 %>%
    select(total, hour) %>%
    ggplot(aes(x=hour, y=total))+
    geom_bar(stat="identity", fill = "#FF6666", alpha=0.7) +
    xlab("Date") +
    ylab("Deep Sleep")
  
  df30 <- df3 %>%
    select(total, hour) %>%
    ggplot(aes(x=hour, y=total))+
    geom_bar(stat="identity", fill = "#FF6666", alpha=0.7) +
    xlab("Date") +
    ylab("Flights Climbed")
  
  df40 <- df4 %>%
    select(total, hour) %>%
    ggplot(aes(x=hour, y=total))+
    geom_bar(stat="identity", fill = "#FF6666", alpha=0.7) +
    xlab("Date") +
    ylab("HeartRate")
  
  df50 <- df5 %>%
    select(total, hour) %>%
    ggplot(aes(x=hour, y=total))+
    geom_bar(stat="identity", fill = "#FF6666", alpha=0.7) +
    xlab("Date") +
    ylab("Sleep")
  
  df60 <- df6 %>%
    select(total, hour) %>%
    ggplot(aes(x=hour, y=total))+
    geom_bar(stat="identity", fill = "#FF6666", alpha=0.7) +
    xlab("Date") +
    ylab("Sleep Heartrate")
  
  df70 <- df7 %>%
    select(total, hour) %>%
    ggplot(aes(x=hour, y=total))+
    geom_bar(stat="identity", fill = "#FF6666", alpha=0.7) +
    xlab("Date") +
    ylab("Step Counter")
  
  df80 <- df8 %>%
    select(total, hour) %>%
    ggplot(aes(x=hour, y=total))+
    geom_bar(stat="identity", fill = "#FF6666", alpha=0.7) +
    xlab("Date") +
    ylab("Walking Running Distance")
  
  dfstress <- conv9 %>%
    mutate(startdate = ymd_hms(startdate)) %>%
    select(stresslevel, startdate) %>%
    ggplot(aes(x=startdate, y=stresslevel))+
    geom_bar(stat="identity", fill = "#FF6666", alpha=0.7) +
    xlab("Date") +
    ylab("Stress Level")
  
  dftired <- conv9 %>%
    mutate(startdate = ymd_hms(startdate)) %>%
    select(tirednesslevel, startdate) %>%
    ggplot(aes(x=startdate, y=tirednesslevel))+
    geom_bar(stat="identity", fill = "#FF6666", alpha=0.7) +
    xlab("Date") +
    ylab("Tiredness Level")
  
  dfhealth <- conv9 %>%
    mutate(startdate = ymd_hms(startdate)) %>%
    select(healthinesslevel, startdate) %>%
    ggplot(aes(x=startdate, y=healthinesslevel))+
    geom_bar(stat="identity", fill = "#FF6666", alpha=0.7) +
    xlab("Date") +
    ylab("Healthiness Level")
  
  dfactive <- conv9 %>%
    mutate(startdate = ymd_hms(startdate)) %>%
    select(activitylevel, startdate) %>%
    ggplot(aes(x=startdate, y=activitylevel))+
    geom_bar(stat="identity", fill = "#FF6666", alpha=0.7) +
    xlab("Date") +
    ylab("Activity Level")
  
  dfscatstress <- conv9 %>%
    mutate(startdate = ymd_hms(startdate)) %>%
    select(stresslevel, startdate) %>%
    ggplot(aes(x=startdate, y=stresslevel))+
    geom_point(aes(y = stresslevel) ,colour = "#FFA500", alpha=0.7) +
    geom_line(alpha=0.5) +
    xlab("Date") +
    ylab("Stress Level")
  
  dfscattired <- conv9 %>%
    mutate(startdate = ymd_hms(startdate)) %>%
    select(tirednesslevel, startdate) %>%
    ggplot(aes(x=startdate, y=tirednesslevel))+
    geom_point(aes(y = tirednesslevel) ,colour = "#FFA500", alpha=0.7) +
    geom_line(alpha=0.5) +
    xlab("Date") +
    ylab("Tiredness Level")
  
  dfscathealth <- conv9 %>%
    mutate(startdate = ymd_hms(startdate)) %>%
    select(healthinesslevel, startdate) %>%
    ggplot(aes(x=startdate, y=healthinesslevel))+
    geom_point(aes(y = healthinesslevel) ,colour = "#FFA500", alpha=0.7) +
    geom_line(alpha=0.5) +
    xlab("Date") +
    ylab("Healthiness Level")
  
  dfscatactive <- conv9 %>%
    mutate(startdate = ymd_hms(startdate)) %>%
    select(activitylevel, startdate) %>%
    ggplot(aes(x=startdate, y=activitylevel))+
    geom_point(aes(y = activitylevel) ,colour = "#FFA500", alpha=0.7) +
    geom_line(alpha=0.5) +
    xlab("Date") +
    ylab("Activity Level")
  
  
  dfA <- ggarrange(df10, df20, df30, df40, df50, df60, df70, df80, dfstress, dftired, dfhealth, dfactive, dfscatstress, dfscattired, dfscathealth, dfscatactive
                   + rremove("x.text"),
            ncol = 4, nrow = 4)
  
  plot(dfA)
    
}

hexColor <- function(key){
  hex <- c('activeenergyburned','#66ffcc',"deepsleep", '#ff66cc', 'flightsclimbed', '#ccff99', 'heartrate', '#cc66ff', 'sleep', '#6699ff', 'sleepheartrate', '#33ccff', 'stepcounter', '#ff9999', 'walkingrunningdistance', '#ff9933',
           'stresslevel', '#33cccc', "tirednesslevel",'#3366ff' ,"activitylevel", '#ff5050',"healthinesslevel",'#ffff00')
  colors <- matrix(hex, nrow=12,ncol=2, byrow = TRUE)
  color <- ''
  counter <- 1
  for(item in colors) {
    if(item == key) {
      color <- colors[counter,2]
    }
    counter <- counter +1
  }
  print("================")
  print(color)
  print("================")
  color
}

legendColors <-function(parameters) {
  View(parameters)
  hex <- c('activeenergyburned','#66ffcc',"deepsleep", '#ff66cc', 'flightsclimbed', '#ccff99', 'heartrate', '#cc66ff', 'sleep', '#6699ff', 'sleepheartrate', '#33ccff', 'stepcounter', '#ff9999', 'walkingrunningdistance', '#ff9933', 
           'stresslevel', '#33cccc', "tirednesslevel",'#3366ff' ,"activitylevel", '#ff5050',"healthinesslevel",'#ffff00')
  colors <- matrix(hex, nrow=12,ncol=2, byrow = TRUE)
  data <- matrix(0,length(parameters),1)
  counter <- 1
  
  print(parameters)
  for(p in parameters){
   # print(length(colors[1,]))
    colorCounter <- 1
    for(c in colors[,1]){
      #print(c)
      if(p == c){
        data[counter] <- colors[colorCounter,2]
      }
      colorCounter <- colorCounter +1
    }
    counter <- counter +1
  }

  View(data)
  data
}

dashboardPlot <-function(parameter, total,date, index){
  hex <- hexColor(parameter)
  if(parameter == 'activeenergyburned' ||parameter == 'deepsleep' || parameter == 'flightsclimbed' ||
     parameter == 'sleep' || parameter == 'stepcounter' || parameter == 'walkingrunningdistance' ) {
    #sum
    if(index == 1){
      #first plot display time frame 
      plot(aggregate(as.numeric(total),by=list((as.Date(ymd_hms(date)))),sum), type = 'l', col=hex, yaxt='n', xlab = "", ylab = "",  lwd=5)
      
    } else {
      plot(aggregate(as.numeric(total),by=list((as.Date(ymd_hms(date)))),sum), type = 'l', col=hex, yaxt='n', xaxt='n', xlab = "", ylab = "",  lwd=5)
    }
   
  }
  else{
    #mean
    if(index == 1){
    plot(aggregate(as.numeric(total),by=list((as.Date(ymd_hms(date)))),mean), type = 'l', col=hex, yaxt='n', xlab = "", ylab = "",  lwd=5)
    } else {
      plot(aggregate(as.numeric(total),by=list((as.Date(ymd_hms(date)))),mean), type = 'l', col=hex,  yaxt='n', xaxt='n', xlab = "", ylab = "",  lwd=5)
    }
  }
}


#' dashboard plot
#' @param dataset1
#' @post /dashboardplot
#' @png 
function(dataset1,parameter1) {
  par(new=TRUE)
  counter <- 1
  for(item in dataset1){
    dashboardPlot(parameter1[counter],dataset1[[counter]]$total, dataset1[[counter]]$date, counter)
    par(new=TRUE)
    counter <- counter + 1
  }
  legend('topright', legend=parameter1,col=legendColors(parameter1), lty=1:2, cex=0.8)

}



#' Correlation endpoint
#' @param dataset1 The first dataset
#' @param dataset2 The second dataset
#' @param parameter1 1st parameter
#' @param parameter2 2nd parameter
#' @param duration Month, Week, Day, Hours
#' @post /correlation
#' @png (width = 1000, height = 1000)
function(dataset1,
         dataset2,
         parameter1,
         parameter2,
         duration) {
  options(scipen=999)
  print('hello world')
  conv <- as.data.frame(dataset1)
  conv2 <- as.data.frame(dataset2)

  
  userinputvalues <- c('stresslevel','tirednesslevel','activitylevel','healthinesslevel')
  watchinputvalues <- c('activeenergyburned','deepsleep','flightsclimbed','heartrate','sleep','sleepheartrate','stepcounter','walkingrunningdistance')
  heartratevalues <- c('heartrate','sleepheartrate')
  
  if(parameter1 %in% watchinputvalues && parameter2 %in% watchinputvalues){
    #watchwatch
    
    if(parameter1 %in% heartratevalues){
      df1 <- meantotal(conv, 'hour')
      df2 <- meantotal(conv, '1 day')
      df3 <- meantotal(conv, '7 days')
      df4 <- meantotal(conv, '30 days')
    }else{
      df1 <- sumtotal(conv, 'hour')
      df2 <- sumtotal(conv, '1 day')
      df3 <- sumtotal(conv, '7 days')
      df4 <- sumtotal(conv, '30 days')
    }
    
    if(parameter2 %in% heartratevalues){
      df10 <- meantotal(conv2,'hour')
      df20 <- meantotal(conv2, '1 day')
      df30 <- meantotal(conv2, '7 days')
      df40 <- meantotal(conv2, '30 days')
    }else{
      df10 <- sumtotal(conv2, 'hour')
      df20 <- sumtotal(conv2, '1 day')
      df30 <- sumtotal(conv2, '7 days')
      df40 <- sumtotal(conv2, '30 days')
    }
  }else if(parameter1 %in% userinputvalues && parameter2 %in% userinputvalues){
    #useruser
    
    df1 <- meantotal(conv, 'hour')
    df2 <- meantotal(conv, '1 day')
    df3 <- meantotal(conv, '7 days')
    df4 <- meantotal(conv, '30 days')
    
    df10 <- meantotal(conv2,'hour')
    df20 <- meantotal(conv2, '1 day')
    df30 <- meantotal(conv2, '7 days')
    df40 <- meantotal(conv2, '30 days')
  }
  
  df100 <- df10[(df10$hour %in% df1$hour), ]
  df200 <- df1[(df1$hour %in% df10$hour), ]

  df300 <- df20[(df20$hour %in% df2$hour), ]
  df400 <- df2[(df2$hour %in% df20$hour), ]

  df500 <- df30[(df30$hour %in% df3$hour), ]
  df600 <- df3[(df3$hour %in% df30$hour), ]

  df700 <- df40[(df40$hour %in% df4$hour), ]
  df800 <- df4[(df4$hour %in% df40$hour), ]

  
  
  title <-
    paste("Correlation between", parameter1, "and", parameter2, "over ...", sep = " ")
  
  attach(mtcars)
  par(mfrow=c(2,2), mar=c(5,4,6,2), cex=1.5)
  
  plot(df100$total, df200$total, type = "p", ann = FALSE)
  title("1 Hour", xlab = parameter1, ylab = parameter2)

  plot(df300$total, df400$total, type = "p", ann = FALSE)
  title("1 Day", xlab = parameter1, ylab = parameter2)

  plot(df500$total, df600$total, type = "p", ann = FALSE)
  title("1 Week", xlab = parameter1, ylab = parameter2)

  plot(df700$total, df800$total, type = "p", ann = FALSE)
  title("1 Month", xlab = parameter1, ylab = parameter2)

  mtext(title, side = 3, line = -2, outer=TRUE, cex = 2.5)
  
  
  # if(parameter1 == 'heartrate' || parameter1 == 'sleepheartrate'){
  #   df1 <- meantotal(conv, 'hour')
  #   df2 <- meantotal(conv, '1 day')
  #   df3 <- meantotal(conv, '7 days')
  #   df4 <- meantotal(conv, '30 days')
  # }else{
  #   df1 <- sumtotal(conv, 'hour')
  #   df2 <- sumtotal(conv, '1 day')
  #   df3 <- sumtotal(conv, '7 days')
  #   df4 <- sumtotal(conv, '30 days')
  # }
  # 
  # if(parameter2 == 'heartrate' || parameter2 == 'sleepheartrate'){
  #   df10 <- meantotal(conv2,'hour')
  #   df20 <- meantotal(conv2, '1 day')
  #   df30 <- meantotal(conv2, '7 days')
  #   df40 <- meantotal(conv2, '30 days')
  #   
  # }else{
  #   df10 <- sumtotal(conv2, 'hour')
  #   df20 <- sumtotal(conv2, '1 day')
  #   df30 <- sumtotal(conv2, '7 days')
  #   df40 <- sumtotal(conv2, '30 days')
  # }
  
}


#' information about mood and watch data
#' @param dataset1 The first dataset  
#' @param parameter1 The name of datase1
#' @param parameter2 The name of dataset2
#' @post /datasetInformationMoodWatch
function(dataset1,parameter1,parameter2){
  hourplotMatrix <- matrix(0,length(dataset1$hourData),2)
  threehourplotMatrix <- matrix(0,length(dataset1$threeHourData),2)
  sixhourplotMatrix <- matrix(0,length(dataset1$sixHourData),2)
  twelvehourplotMatrix <- matrix(0,length(dataset1$twelveHourData),2)
  
  counter <- 1
  for(item in dataset1$hourData){
    #View(item)
    hourplotMatrix[counter, 1] <- as.numeric(item$watch)
    hourplotMatrix[counter, 2] <- as.numeric(item$mood)
    counter <- counter + 1
  }
  
  counter <- 1
  for(item in dataset1$threeHourData){
    #View(item)
    threehourplotMatrix[counter, 1] <- as.numeric(item$watch)
    threehourplotMatrix[counter, 2] <- as.numeric(item$mood)
    counter <- counter + 1
  }
  
  counter <- 1
  for(item in dataset1$sixHourData){
    #View(item)
    sixhourplotMatrix[counter, 1] <- as.numeric(item$watch)
    sixhourplotMatrix[counter, 2] <- as.numeric(item$mood)
    counter <- counter + 1
  }
  
  counter <- 1
  for(item in dataset1$twelveHourData){
    #View(item)
    twelvehourplotMatrix[counter, 1] <- as.numeric(item$watch)
    twelvehourplotMatrix[counter, 2] <- as.numeric(item$mood)
    counter <- counter + 1
  }
  

  
  if(parameter1 == 'heartrate' || parameter1 == 'sleepheartrate'){
    #mean
    hourDataWatch <- mean(hourplotMatrix[,1])
    threehourDataWatch <- mean(threehourplotMatrix[,1])
    sixhourDataWatch <- mean(sixhourplotMatrix[,1])
    twelvehourDataWatch <- mean(twelvehourplotMatrix[,1])
  } else {
    #sum
    hourDataWatch <- sum(hourplotMatrix[,1])
    threehourDataWatch <- sum(threehourplotMatrix[,1])
    sixhourDataWatch <- sum(sixhourplotMatrix[,1])
    twelvehourDataWatch <- sum(twelvehourplotMatrix[,1])
  }
  
  hourCor <- cor(hourplotMatrix[,1],hourplotMatrix[,2])
  threehourCor <- cor(threehourplotMatrix[,1],threehourplotMatrix[,2])
  sixhourCor <- cor(sixhourplotMatrix[,1],sixhourplotMatrix[,2])
  twelvehourCor <- cor(twelvehourplotMatrix[,1],twelvehourplotMatrix[,2])
  hourT <- tTestJSON(hourplotMatrix[,1],hourplotMatrix[,2])
  threehourT <- tTestJSON(threehourplotMatrix[,1],threehourplotMatrix[,2])
  sixhourT <- tTestJSON(sixhourplotMatrix[,1],sixhourplotMatrix[,2])
  twelvehourT <- tTestJSON(twelvehourplotMatrix[,1],twelvehourplotMatrix[,2])
  
  watchSummaryHour <- datasetSummaryMoodWatch(hourplotMatrix[,1])
  watchSummaryThreeHour <- datasetSummaryMoodWatch(threehourplotMatrix[,1])
  watchSummarySixHour <- datasetSummaryMoodWatch(sixhourplotMatrix[,1])
  watchSummaryTwelveHour <- datasetSummaryMoodWatch(twelvehourplotMatrix[,1])
 
  json <- list(hourDataWatch,threehourDataWatch,sixhourDataWatch,twelvehourDataWatch,
               hourCor,threehourCor,sixhourCor,twelvehourCor,
               hourT,threehourT,sixhourT,twelvehourT,
               watchSummaryHour,watchSummaryThreeHour,watchSummarySixHour,watchSummaryTwelveHour)
  names(json) <- c("hourDataWatch","threehourDataWatch","sixhourDataWatch","twelvehourDataWatch",
                   "hourCor","threehourCor","sixhourCor","twelvehourCor",
                   "hourT","threehourT","sixhourT","twelvehourT",
                   "watchSummaryHour","watchSummaryThreeHour","watchSummarySixHour","watchSummaryTwelveHour")
  
  json <- toJSON(json)
}







#' Infomation about dataset 1 and 2 
#' @param dataset1 The first dataset  
#' @param dataset2 The second dataset
#' @param parameter1 The name of datase1
#' @param parameter2 The name of dataset2
#' @post /datasetInformation
function(dataset1,dataset2,parameter1,parameter2){
  conv <- as.data.frame(dataset1)
  conv2 <- as.data.frame(dataset2)
  View(conv)
  View(conv2)
  
  if(parameter1 == 'heartrate' || parameter1 == 'sleepheartrate'){
    df1 <- meantotal(conv, 'hour')
    df2 <- meantotal(conv, '1 day')
    df3 <- meantotal(conv, '7 days')
    df4 <- meantotal(conv, '30 days')
  }else{
    df1 <- sumtotal(conv, 'hour')
    df2 <- sumtotal(conv, '1 day')
    df3 <- sumtotal(conv, '7 days')
    df4 <- sumtotal(conv, '30 days')
  }
  
  if(parameter2 == 'heartrate' || parameter2 == 'sleepheartrate'){
    df10 <- meantotal(conv2,'hour')
    df20 <- meantotal(conv2, '1 day')
    df30 <- meantotal(conv2, '7 days')
    df40 <- meantotal(conv2, '30 days')
    
  }else{
    df10 <- sumtotal(conv2, 'hour')
    df20 <- sumtotal(conv2, '1 day')
    df30 <- sumtotal(conv2, '7 days')
    df40 <- sumtotal(conv2, '30 days')
  }
  
  
  df100 <- df10[(df10$hour %in% df1$hour), ]
  df200 <- df1[(df1$hour %in% df10$hour), ]
  
  
  df300 <- df20[(df20$hour %in% df2$hour), ]
  df400 <- df2[(df2$hour %in% df20$hour), ]
  
  
  df500 <- df30[(df30$hour %in% df3$hour), ]
  df600 <- df3[(df3$hour %in% df30$hour), ]
  
  
  df700 <- df40[(df40$hour %in% df4$hour), ]
  df800 <- df4[(df4$hour %in% df40$hour), ]
  
  
  json <- list(datasetSummary(dataset1),datasetSummary(dataset2),correlation(df100,df200),correlation(df300,df400),correlation(df500,df600),correlation(df700,df800),
               tTestJSON(df100$total,df200$total),tTestJSON(df300$total,df400$total),tTestJSON(df500$total,df600$total),tTestJSON(df700$total,df800$total))
  names(json) <- c("dataset1", "dataset2","hourCor","1dayCor","7daysCor","30daysCor","hourTest","1dayTest","7daysTest","30daysTest")
  json <- toJSON(json)
  
}



#' MoodWatchCorrelation endpoint
#' @param dataset1 The first dataset
#' @param parameter1 1st parameter
#' @param parameter2 2nd parameter
#' @post /testendpoint
#' @png (width = 1000, height = 1000)
function(dataset1,parameter1,parameter2) {
  View(dataset1)
  View(parameter1)
  View(parameter2)
  options(scipen=999)
  hourplotMatrix <- matrix(0,length(dataset1$hourData),2)
  threehourplotMatrix <- matrix(0,length(dataset1$threeHourData),2)
  sixhourplotMatrix <- matrix(0,length(dataset1$sixHourData),2)
  twelvehourplotMatrix <- matrix(0,length(dataset1$twelveHourData),2)
  
  counter <- 1
  for(item in dataset1$hourData){
    #View(item)
    hourplotMatrix[counter, 1] <- as.numeric(item$watch)
    hourplotMatrix[counter, 2] <- as.numeric(item$mood)
    counter <- counter + 1
  }
  
  counter <- 1
  for(item in dataset1$threeHourData){
    #View(item)
    threehourplotMatrix[counter, 1] <- as.numeric(item$watch)
    threehourplotMatrix[counter, 2] <- as.numeric(item$mood)
    counter <- counter + 1
  }
  
  counter <- 1
  for(item in dataset1$sixHourData){
    #View(item)
    sixhourplotMatrix[counter, 1] <- as.numeric(item$watch)
    sixhourplotMatrix[counter, 2] <- as.numeric(item$mood)
    counter <- counter + 1
  }
  
  counter <- 1
  for(item in dataset1$twelveHourData){
    #View(item)
    twelvehourplotMatrix[counter, 1] <- as.numeric(item$watch)
    twelvehourplotMatrix[counter, 2] <- as.numeric(item$mood)
    counter <- counter + 1
  }
  
  
   title <-
    paste("Correlation between", parameter1, "and", parameter2, "over ...", sep = " ")
   attach(mtcars)
   par(mfrow=c(2,2), mar=c(5,4,6,2), cex=1.5)
   #watch mood
   plot(hourplotMatrix[,1],hourplotMatrix[,2],type = "p", ann = FALSE)
   title("1 Hour", xlab = parameter1, ylab = parameter2)
   
   plot(threehourplotMatrix[,1],threehourplotMatrix[,2] , type = "p", ann = FALSE)
   title("3 Hours", xlab = parameter1, ylab = parameter2)
   
   plot(sixhourplotMatrix[,1],sixhourplotMatrix[,2], type = "p", ann = FALSE)
   title("6 Hours", xlab = parameter1, ylab = parameter2)
   
   plot(twelvehourplotMatrix[,1],twelvehourplotMatrix[,2], type = "p", ann = FALSE)
   title("12 Hours", xlab = parameter1, ylab = parameter2)
   
   mtext(title, side = 3, line = -2, outer=TRUE, cex = 2.5)
  

  
}







#' MoodWatchCorrelation endpoint
#' @param dataset1 The first dataset
#' @param dataset2 The second dataset
#' @param parameter1 1st parameter
#' @param parameter2 2nd parameter
#' @post /moodwatchcorrelation
#' @png (width = 1000, height = 1000)
function(dataset1,
         dataset2,
         parameter1,
         parameter2) {
  options(scipen=999)
  
     conv <- as.data.frame(dataset1)
     conv2 <- as.data.frame(dataset2)
     View(conv)
     View(conv2)
  
  userinputvalues <- c('stresslevel','tirednesslevel','activitylevel','healthinesslevel')
  watchinputvalues <- c('activeenergyburned','deepsleep','flightsclimbed','heartrate','sleep','sleepheartrate','stepcounter','walkingrunningdistance')
  heartratevalues <- c('heartrate','sleepheartrate')
  
  if(parameter1 %in% userinputvalues || parameter1 %in% heartratevalues){
    df1 <- meantotal(conv, '3 hours')
    df2 <- meantotal(conv, '6 hours')
    df3 <- meantotal(conv, '1 day')
    df4 <- meantotal(conv, '10 days')
  }else{
    df1 <- sumtotal(conv, '3 hours')
    df2 <- sumtotal(conv, '6 hours')
    df3 <- sumtotal(conv, '1 day')
    df4 <- sumtotal(conv, '10 days')
  }
  
  if(parameter2 %in% userinputvalues || parameter2 %in% heartratevalues){
    df10 <- meantotal(conv, '3 hours')
    df20 <- meantotal(conv, '6 hours')
    df30 <- meantotal(conv, '1 day')
    df40 <- meantotal(conv, '10 days')
  }else{
    df10 <- sumtotal(conv, '3 hours')
    df20 <- sumtotal(conv, '6 hours')
    df30 <- sumtotal(conv, '1 day')
    df40 <- sumtotal(conv, '10 days')
  }
  
  df100 <- df10[(df10$hour %in% df1$hour), ]
  df200 <- df1[(df1$hour %in% df10$hour), ]
  
  df300 <- df20[(df20$hour %in% df2$hour), ]
  df400 <- df2[(df2$hour %in% df20$hour), ]
  
  df500 <- df30[(df30$hour %in% df3$hour), ]
  df600 <- df3[(df3$hour %in% df30$hour), ]
  
  df700 <- df40[(df40$hour %in% df4$hour), ]
  df800 <- df4[(df4$hour %in% df40$hour), ]
  
  
  
  title <-
    paste("Correlation between", parameter1, "and", parameter2, "over ...", sep = " ")
  
  attach(mtcars)
  par(mfrow=c(2,2), mar=c(5,4,6,2), cex=1.5)
  
  plot(df100$total, df200$total, type = "p", ann = FALSE)
  title("1 Hour", xlab = parameter1, ylab = parameter2)
  
  plot(df300$total, df400$total, type = "p", ann = FALSE)
  title("1 Day", xlab = parameter1, ylab = parameter2)
  
  plot(df500$total, df600$total, type = "p", ann = FALSE)
  title("1 Week", xlab = parameter1, ylab = parameter2)
  
  plot(df700$total, df800$total, type = "p", ann = FALSE)
  title("1 Month", xlab = parameter1, ylab = parameter2)
  
  mtext(title, side = 3, line = -2, outer=TRUE, cex = 2.5)
  
  
  # if(parameter1 %in% moodvalues){
  #   #dataset1 represents mood data from express
  #   #dataset2 represents watch data from express
  #   
  #   conv <- as.data.frame(dataset1)
  #   conv2 <- as.data.frame(dataset2)
  #   View(conv)
  #   View(conv2)
  #   
  #   #dfMoodData and dfWatchData are created from the formatted datasets coming from express
  #   
  #   dfMoodData <- conv %>%
  #     mutate(startdate = ymd_hms(startdate)) %>%
  #     select(startdate, id, level)
  #   
  #   dfWatchData <- conv2 %>%
  #     mutate(startdate = ymd_hms(startdate)) %>%
  #     mutate(total = as.numeric(total)) %>%
  #     select(startdate, total)  
  #   
  #   #moodwatchmean and moodwatchsum aggregate the watch data using the mood submission timestamps
  #   #heartrate values are aggregated by mean
  #   #dfAggrMoodWatch is a single dataframe that consists of the full join of mood data and aggregated watch data
  #   #by mood submission timestamps
  #   
  #   meanparameters <- c('heartrate','sleepheartrate')
  #   
  #     if(parameter2 %in% meanparameters || parameter2 %in% meanparameters){
  #       dfAggrMoodWatch <- moodwatchmean(dfMoodData, dfWatchData)  
  #     }else{
  #       dfAggrMoodWatch <- moodwatchsum(dfMoodData, dfWatchData)
  #     }
  #   
  #   #dfAggrMoodWatch is used to create dfAggrMood and dfAggrWatch. They consist of the useful columns
  #   #if further aggregation is required
  #   
  #   dfAggrMood <- dfAggrMoodWatch %>%
  #     select(startdate, level, total)
  #   
  #   dfAggrWatch <- dfAggrMoodWatch %>%
  #     select(startdate, total)
  #   
  #   plot(dfAggrMood$level, dfAggrWatch$total, type = "p", ann = FALSE)
  #   
  # }else{
  #   #if parameter 1 was not included in the moodvalues list, parameter 2 is a mood values,
  #   #therefore dataset1 (which is mood data) is assigned to conv2
  #   #dataset2 (watch data)  is assigned to conv
  #   
  #   conv <- as.data.frame(dataset2) 
  #   conv2 <- as.data.frame(dataset1)
  #   
  #   #dfMoodData and dfWatchData are created from the formatted datasets coming from express
  #   
  #   dfMoodData <- conv2 %>%
  #     mutate(startdate = ymd_hms(startdate)) %>%
  #     select(startdate, id, level)
  #   
  #   dfWatchData <- conv %>%
  #     mutate(startdate = ymd_hms(startdate)) %>%
  #     mutate(total = as.numeric(total)) %>%
  #     select(startdate, total)  
  #   
  #   meanparameters <- c('heartrate','sleepheartrate')
  #   
  #     if(parameter1 %in% meanparameters || parameter1 %in% meanparameters){
  #       dfAggrMoodWatch <- moodwatchmean(dfMoodData, dfWatchData)
  #     }else{
  #       dfAggrMoodWatch <- moodwatchsum(dfMoodData, dfWatchData)
  #     }
  #   
  #   dfAggrMood <- dfAggrMoodWatch %>%
  #     select(startdate, level)
  #   
  #   dfAggrWatch <- dfAggrMoodWatch %>%
  #     select(startdate, total)
  #   
  #   plot(dfAggrMood$level, dfAggrWatch$total, type = "p", ann = FALSE)
  #   
  # }
  
  
}


tTestJSON <- function(data1,data2){
  item <- t.test(data1,data2,paired=TRUE)
  
  json <- list(item[["statistic"]][["t"]], item[["p.value"]], item[["estimate"]][["mean of the differences"]],item[["conf.int"]])
  names(json) <- c("tValue", "pValue", "MD", "confInt")
  json
  
}

correlation <- function(dataset1, dataset2) {
  d1 <- as.data.frame(as.numeric(dataset1$total))
  d2 <- as.data.frame(as.numeric(dataset2$total))
  cor(d1, d2)
}


datasetSummaryMoodWatch <- function(dataset) {
  convJSON <- as.data.frame(as.numeric(dataset))
  datasetStats <- as.data.frame(summary(convJSON))
  View(datasetStats)
  datasetStatsObject<-datasetStats %>%
    select(Freq)
  datasetStatsObject 
}


datasetSummary <- function(dataset) {
  convJSON <- as.data.frame(as.numeric(dataset$total))
  datasetStats <- as.data.frame(summary(convJSON))
  View(datasetStats)
  datasetStatsObject<-datasetStats %>%
    select(Freq)
  datasetStatsObject 
}

sumtotal <- function(conv, duration1){
  conv %>%
    mutate(startdate = ymd_hms(startdate)) %>%
    mutate(total = as.numeric(total)) %>%
    mutate(month_name = month(startdate)) %>%
    group_by(hour = floor_date(startdate, duration1)) %>%
    summarize(total = sum(total))
}

meantotal <- function(conv, duration1){
  print(duration1)
  conv %>%
    mutate(startdate = ymd_hms(startdate)) %>%
    mutate(total = as.numeric(total)) %>%
    mutate(month_name = month(startdate)) %>%
    group_by(hour = floor_date(startdate, duration1)) %>%
    summarize(total = mean(total))
}

moodwatchsum <- function(dfMood, dfWatch){
  
    full_join(dfMood, dfWatch, by = "startdate") %>% 
    arrange(startdate) %>% 
    fill(id, level, .direction = "up") %>% 
    group_by(id, level) %>% 
    summarize(total = sum(total, na.rm = TRUE)) %>%
    na.omit() %>%
    ungroup() %>% 
    select(total) %>% 
    bind_cols(dfMood, .)
  
}

moodwatchmean <- function(dfMood, dfWatch){
  
  full_join(dfMood, dfWatch, by = "startdate") %>% 
    arrange(startdate) %>% 
    fill(id, level, .direction = "up") %>% 
    group_by(id, level) %>% 
    summarize(total = sum(total, na.rm = TRUE)) %>% #should be mean instead of sum here
    na.omit() %>%
    ungroup() %>% 
    select(total) %>% 
    bind_cols(dfMood, .)
  
}
