function nnrun (inputid)
	load(inputid);
	readwritecfg;
	load('template');

	[best_mse, num_of_epochs, training_set_size, tset_performance, val_set_size, vset_performance, vset_outputs] = nn(X, y, input_layer_size, hidden_layer_size, num_labels, lr, mom, min_mse, max_epochs);

	if(strcmp(inputid, 'cancer'))
		save("-text","cancer.txt","best_mse", "num_of_epochs", "training_set_size", "tset_performance", "val_set_size", "vset_performance", "vset_outputs");
	elseif(strcmp(inputid, 'identity'))
		save("-text","identity.txt","best_mse", "num_of_epochs", "training_set_size", "tset_performance", "val_set_size", "vset_performance", "vset_outputs");
	else(strcmp(inputid, 'xor'))
		save("-text","xor.txt","best_mse", "num_of_epochs", "training_set_size", "tset_performance", "val_set_size", "vset_performance", "vset_outputs");
	endif

end