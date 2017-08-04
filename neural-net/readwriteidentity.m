filename = "identity.in"
fid = fopen(filename);
ln = fgetl(fid);
XY = [];

for i=1:120
	ln = fgetl(fid);
	arr = strsplit(ln,":");
	arr1 = str2num(arr{1});
	arr2 = str2num(arr{2});
	xy = [arr1 arr2];
	XY = [XY; xy];
end;

X = XY(:,1:8);
y = XY(:,9:16);

save("-mat", "identity.mat", "X", "y");
