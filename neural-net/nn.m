function [best_mse, num_of_epochs, training_set_size, tset_performance, val_set_size, vset_performance, vset_outputs] = nn(X, y, input_layer_size, hidden_layer_size, num_labels, lr, mom, min_mse, max_epochs)
	
	% ================ Initializations ====================== %

	best_mse = 0;
	num_of_epochs = 0;
	training_set_size = 0;
	tset_performance = 0; 
	val_set_size = 0;
	vset_performance = 0;
	vset_outputs = [];

	% randomly initializes weights, Theta1 for those from the input to hidden layer and Theta2 for weights from hidden to output layer
	Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
	Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

	% sets m to be the training set size or the number of rows in X, which represents the training examples
	m = size(X, 1);

	% Y represents the outputs
	Y = y;

	%used for effects of momentum later on
	prev_inc1 = zeros(input_layer_size+1, hidden_layer_size+1);
	prev_inc2 = zeros(hidden_layer_size+1, num_labels);

	num_of_epochs = 0;

	%sets the validation set to be 1/3 the size of the entire set of examples
	val_set_size = (1/3) * m;
	%sets training set to be 2/3 size of the entire set of examples
	training_set_size = m - val_set_size;

	%X_val represents the inputs for the validation set
	X_val = X((training_set_size + 1):m,:);
	%X_val represents the inputs for the training set
	X = X(1:training_set_size,:);

	%initializes outputs for validation set and training set
	Y_val = Y((training_set_size + 1):m,:);
	Y = Y(1:training_set_size,:);

	% ================ Training Set ====================== %

	%adds bias unit%
	X_1 = [ones(training_set_size, 1), X];

	%loops through epochs
	do
		D = [];
		ctrCorrect = 0;
		percentCorrect = 0;
		%loops over training set 
		for i=1:training_set_size,

			%obtains particular training example and stores in X_m
			X_m = X_1(i,:);
			%Oh is the output of the hidden layer
			Oh = [ones(1,1)'; sigmoid(Theta1 * X_m')];
			%Oo is the output at the output layer
			Oo = sigmoid(Theta2 * Oh);
			%Y_m is the target value of that current training example
			Y_m = Y(i,:);
			%error or difference between target and output	  
			d = Y_m - Oo';
			%delta of output layer
			deltaO = d.* (Oo .* (1-Oo))';
			%delta of hidden layer
			deltaH = (deltaO * Theta2) .* (Oh .* (1-Oh))';		 	

			%checking statements for momentum
			if i==1
				prev_inc2 = zeros(size(Theta2));
				prev_inc1 = zeros(size(Theta1));
			else
				prev_inc2 = mom*(Theta2 - Theta2_old);
				prev_inc1 = mom*(Theta1 - Theta1_old);
			endif

			%change of weights for theta 2 and theta 1
			inc2 = (Oh*deltaO*lr)+prev_inc2';
			inc1 = (X_m' * deltaH *lr)(:,2:hidden_layer_size+1) +prev_inc1';		

			Theta2_old = Theta2;
			Theta1_old = Theta1;		

			%updating of thetas
			Theta2 = Theta2  + inc2';
			Theta1 = Theta1  + inc1';		

			%accumulated errors over all the training examples
			D = [D; d];

			%checks correctness of output, if the error is less than 0.15, it is classified as correct
			if (abs(d) <= 0.15)
				ctrCorrect++;
			endif

		end;

		%computation of mse
		mse = sum(sum(D.^2))/2;
		%checks performance
		percentCorrect = (ctrCorrect / training_set_size) * 100;
		num_of_epochs++;
	until ((num_of_epochs == max_epochs) || (mse <= min_mse))

	best_mse = mse;

	Theta1_final = Theta1_old;
	Theta2_final = Theta2_old;

	tset_performance = percentCorrect;
	fprintf('Performance Over Training Set: %f\n', tset_performance');


	% ================ Validation Set ====================== %

	X_1 = [ones(val_set_size, 1), X_val];
		
	ctrCorrect = 0;
	classification_display = [];

	%similar to training set, performs feedforward and computes error to determine correctness
	for i=1:val_set_size,
		correct = 0;
		X_m = X_1(i,:);
		Oh = [ones(1,1)'; sigmoid(Theta1_final * X_m')];
		Oo = sigmoid(Theta2_final * Oh);
		Y_m = Y_val(i,:);	  
		d = Y_m - Oo';

		d = (sum(d.^2))/2;
		if (d <= 0.15)
			ctrCorrect++;
			correct = 1;
		endif

		output = [X_m Y_m Oo' correct]; 
		vset_outputs = [vset_outputs; output];
	end;

	mse = sum(sum(D.^2))/2;
	fprintf('MSE: %f\n', mse');

	percentCorrect = (ctrCorrect / val_set_size) * 100;
	vset_performance = percentCorrect;
	fprintf('Performance Over Validation Set: %f\n', vset_performance');

end