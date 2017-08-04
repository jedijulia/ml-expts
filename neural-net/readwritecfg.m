filename = "template.cfg"
fid = fopen(filename);

ln = fgetl(fid);
linesep = strsplit(ln,":");
structure = str2num(linesep{2});
input_layer_size = structure(1);
hidden_layer_size = structure(2);
num_labels = structure(3);

ln = fgetl(fid);
linesep = strsplit(ln,":");
lr = str2num(linesep{2});

ln = fgetl(fid);
linesep = strsplit(ln,":");
mom = str2num(linesep{2});

ln = fgetl(fid);
linesep = strsplit(ln,":");
min_mse = str2num(linesep{2});

ln = fgetl(fid);
linesep = strsplit(ln,":");
max_epochs = str2num(linesep{2});

save("-mat", "template.mat", "input_layer_size", "hidden_layer_size", "num_labels", "lr", "mom", "min_mse", "max_epochs");
