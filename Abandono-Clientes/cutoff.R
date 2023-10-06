# Useful functions when working with logistic regression
library(ROCR)
library(grid)
library(caret)
library(dplyr)
library(scales)
library(ggplot2)
library(gridExtra)
library(data.table)

# --------------------------------------------------------------------------------------------
# función para plotear la matriz de confusión (tomado de stackoverflow)
draw_confusion_matrix <- function(cm) {
  
  layout(matrix(c(1,1,2)))
  par(mar=c(2,2,2,2))
  plot(c(100, 345), c(300, 450), type = "n", xlab="", ylab="", xaxt='n', yaxt='n')
  title('CONFUSION MATRIX', cex.main=2)
  
  # create the matrix 
  rect(150, 430, 240, 370, col='#3F97D0')
  text(195, 435, 'Class1', cex=1.2)
  rect(250, 430, 340, 370, col='#F7AD50')
  text(295, 435, 'Class2', cex=1.2)
  text(125, 370, 'Predicted', cex=1.3, srt=90, font=2)
  text(245, 450, 'Actual', cex=1.3, font=2)
  rect(150, 305, 240, 365, col='#F7AD50')
  rect(250, 305, 340, 365, col='#3F97D0')
  text(140, 400, 'Class1', cex=1.2, srt=90)
  text(140, 335, 'Class2', cex=1.2, srt=90)
  
  # add in the cm results 
  res <- (cm$table)
  text(195, 400, cm$table[1,1], cex=1.6, font=2, col='white')
  text(195, 335, cm$table[2,1], cex=1.6, font=2, col='white')
  text(295, 400, cm$table[1,2], cex=1.6, font=2, col='white')
  text(295, 335, cm$table[2,2], cex=1.6, font=2, col='white')
  
  # add in the specifics 
  plot(c(100, 0), c(100, 0), type = "n", xlab="", ylab="", main = "DETAILS", xaxt='n', yaxt='n')
  text(10, 85, names(cm$byClass[1]), cex=1.2, font=2)
  text(10, 70, round(as.numeric(cm$byClass[1]), 3), cex=1.2)
  text(30, 85, names(cm$byClass[2]), cex=1.2, font=2)
  text(30, 70, round(as.numeric(cm$byClass[2]), 3), cex=1.2)
  text(50, 85, names(cm$byClass[5]), cex=1.2, font=2)
  text(50, 70, round(as.numeric(cm$byClass[5]), 3), cex=1.2)
  text(70, 85, names(cm$byClass[6]), cex=1.2, font=2)
  text(70, 70, round(as.numeric(cm$byClass[6]), 3), cex=1.2)
  text(90, 85, names(cm$byClass[7]), cex=1.2, font=2)
  text(90, 70, round(as.numeric(cm$byClass[7]), 3), cex=1.2)
  
  # add in the accuracy information 
  text(30, 35, names(cm$overall[1]), cex=1.5, font=2)
  text(30, 20, round(as.numeric(cm$overall[1]), 3), cex=1.4)
  text(70, 35, names(cm$overall[2]), cex=1.5, font=2)
  text(70, 20, round(as.numeric(cm$overall[2]), 3), cex=1.4)
}


# ------------------------------------------------------------------------------------------
# [AccuracyCutoffInfo] : 
# Obtain the accuracy on the trainining and testing dataset.
# for cutoff value ranging from .4 to .8 ( with a .05 increase )
# @train   : your data.table or data.frame type training data ( assumes you have the predicted score in it ).
# @test    : your data.table or data.frame type testing data
# @predict : prediction's column name (assumes the same for training and testing set)
# @actual  : actual results' column name
# returns  : 1. data : a data.table with three columns.
#            		   each row indicates the cutoff value and the accuracy for the 
#            		   train and test set respectively.
# 			 2. plot : plot that visualizes the data.table

AccuracyCutoffInfo <- function( train, valid, predict, actual )
{
	# change the cutoff value's range as you please 
	cutoff <- seq( .1, .99, by = .05 )

	accuracy <- lapply( cutoff, function(c)
	{
		# use the confusionMatrix from the caret package
		cm_train <- confusionMatrix( table(as.numeric( c.train$prediction > c ), c.train$Exited ),positive = "1")
		cm_val  <- confusionMatrix( table(as.numeric( c.val$prediction  > c ), c.val$Exited  ), positive = "1")
			
		dt <- data.table( cutoff = c,
						  train  = cm_train$overall[["Accuracy"]],
		 			      valid   = cm_val$overall[["Accuracy"]] )
		return(dt)
	}) %>% rbindlist()

	# visualize the accuracy of the train and test set for different cutoff value 
	# accuracy in percentage.
	accuracy_long <- gather( accuracy, "data", "accuracy", -1 )
	
	plot <- ggplot( accuracy_long, aes( cutoff, accuracy, group = data, color = data ) ) + 
			geom_line( size = 1 ) + geom_point( size = 3 ) +
			scale_y_continuous( label = percent ) +
			ggtitle( "Train/Val Accuracy for Different Cutoff" )

	return( list( data = accuracy, plot = plot ) )
}


# ------------------------------------------------------------------------------------------
# [ConfusionMatrixInfo] : 
# Obtain the confusion matrix plot and data.table for a given
# dataset that already consists the predicted score and actual outcome.
# @data    : your data.table or data.frame type data that consists the column
#            of the predicted score and actual outcome 
# @predict : predicted score's column name
# @actual  : actual results' column name
# @cutoff  : cutoff value for the prediction score 
# return   : 1. data : a data.table consisting of three column
#            		   the first two stores the original value of the prediction and actual outcome from
#			 		   the passed in data frame, the third indicates the type, which is after choosing the 
#			 		   cutoff value, will this row be a true/false positive/ negative 
#            2. plot : plot that visualizes the data.table 

ConfusionMatrixInfo <- function( data, predict, actual, cutoff )
{	
	# extract the column ;
	# relevel making 1 appears on the more commonly seen position in 
	# a two by two confusion matrix	
	predict <- data[[predict]]
	actual  <- relevel( as.factor( data[[actual]] ), "0" )
	
	result <- data.table( actual = actual, predict = predict )

	# caculating each pred falls into which category for the confusion matrix
	result[ , type := ifelse( predict >= cutoff & actual == 1, "TP",
					  ifelse( predict >= cutoff & actual == 0, "FP", 
					  ifelse( predict <  cutoff & actual == 1, "FN", "TN" ) ) ) %>% as.factor() ]

	# jittering : can spread the points along the x axis 
	plot <- ggplot( result, aes( actual, predict, color = type ) ) + 
			geom_violin( fill = "white", color = NA ) +
			geom_jitter( shape = 1 ) + 
			geom_hline( yintercept = cutoff, color = "blue", alpha = 0.6 ) + 
			scale_y_continuous( limits = c( 0, 1 ) ) + 
			scale_color_discrete( breaks = c( "TP", "FN", "FP", "TN" ) ) + # ordering of the legend 
			guides( col = guide_legend( nrow = 2 ) ) + # adjust the legend to have two rows  
			ggtitle( sprintf( "Matriz de Confusión con Cutoff al %.2f", cutoff ) )

	return( list( data = result, plot = plot ) )
}


# ------------------------------------------------------------------------------------------
# [ROCInfo] : 
# Pass in the data that already consists the predicted score and actual outcome.
# to obtain the ROC curve 
# @data    : your data.table or data.frame type data that consists the column
#            of the predicted score and actual outcome
# @predict : predicted score's column name
# @actual  : actual results' column name
# @cost.fp : associated cost for a false positive 
# @cost.fn : associated cost for a false negative 
# return   : a list containing  
#			 1. plot        : a side by side roc and cost plot, title showing optimal cutoff value
# 				 	   		  title showing optimal cutoff, total cost, and area under the curve (auc)
# 		     2. cutoff      : optimal cutoff value according to the specified fp/fn cost 
#		     3. totalcost   : total cost according to the specified fp/fn cost
#			 4. auc 		: area under the curve
#		     5. sensitivity : TP / (TP + FN)
#		     6. specificity : TN / (FP + TN)

ROCInfo <- function( data, predict, actual, cost.fp, cost.fn )
{
	# calculate the values using the ROCR library
	# true positive, false postive 
	pred <- prediction( data[[predict]], data[[actual]] )
	perf <- performance( pred, "tpr", "fpr" )
	roc_dt <- data.frame( fpr = perf@x.values[[1]], tpr = perf@y.values[[1]] )

	# cost with the specified false positive and false negative cost 
	# false postive rate * number of negative instances * false positive cost + 
	# false negative rate * number of positive instances * false negative cost
	cost <- perf@x.values[[1]] * cost.fp * sum( data[[actual]] == 0 ) + 
			( 1 - perf@y.values[[1]] ) * cost.fn * sum( data[[actual]] == 1 )

	cost_dt <- data.frame( cutoff = pred@cutoffs[[1]], cost = cost )

	# optimal cutoff value, and the corresponding true positive and false positive rate
	best_index  <- which.min(cost)
	best_cost   <- cost_dt[ best_index, "cost" ]
	best_tpr    <- roc_dt[ best_index, "tpr" ]
	best_fpr    <- roc_dt[ best_index, "fpr" ]
	best_cutoff <- pred@cutoffs[[1]][ best_index ]
	
	# area under the curve
	auc <- performance( pred, "auc" )@y.values[[1]]

	# normalize the cost to assign colors to 1
	normalize <- function(v) ( v - min(v) ) / diff( range(v) )
	
	# create color from a palette to assign to the 100 generated threshold between 0 ~ 1
	# then normalize each cost and assign colors to it, the higher the blacker
	# don't times it by 100, there will be 0 in the vector
	col_ramp <- colorRampPalette( c( "green", "orange", "red", "black" ) )(100)   
	col_by_cost <- col_ramp[ ceiling( normalize(cost) * 99 ) + 1 ]

	roc_plot <- ggplot( roc_dt, aes( fpr, tpr ) ) + 
				geom_line( color = rgb( 0, 0, 1, alpha = 0.3 ) ) +
				geom_point( color = col_by_cost, size = 4, alpha = 0.2 ) + 
				geom_segment( aes( x = 0, y = 0, xend = 1, yend = 1 ), alpha = 0.8, color = "royalblue" ) + 
				labs( title = "ROC", x = "False Postive Rate", y = "True Positive Rate" ) +
				geom_hline( yintercept = best_tpr, alpha = 0.8, linetype = "dashed", color = "steelblue4" ) +
				geom_vline( xintercept = best_fpr, alpha = 0.8, linetype = "dashed", color = "steelblue4" )				

	cost_plot <- ggplot( cost_dt, aes( cutoff, cost ) ) +
				 geom_line( color = "blue", alpha = 0.5 ) +
				 geom_point( color = col_by_cost, size = 4, alpha = 0.5 ) +
				 ggtitle( "Costo" ) +
				 scale_y_continuous( labels = comma ) +
				 geom_vline( xintercept = best_cutoff, alpha = 0.8, linetype = "dashed", color = "steelblue4" )	

	# the main title for the two arranged plot
	sub_title <- sprintf( "Cutoff al %.2f - Costo Total = %.1f, AUC = %.3f", 
						  best_cutoff, best_cost, auc )
	
	# arranged into a side by side plot
	plot <- arrangeGrob( roc_plot, cost_plot, ncol = 2, 
						 top = textGrob( sub_title, gp = gpar( fontsize = 16, fontface = "bold" ) ) )
	
	return( list( plot 		  = plot, 
				  cutoff 	  = best_cutoff, 
				  totalcost   = best_cost, 
				  auc         = auc,
				  sensitivity = best_tpr, 
				  specificity = 1 - best_fpr ) )
}

