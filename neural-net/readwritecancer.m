filename = "cancer.in"
fid = fopen(filename);
ln = fgetl(fid);
XY = [];

for i=1:696
	ln = fgetl(fid);
	arr = strsplit(ln,":");
	arr1 = str2num(arr{1});
	arr2 = str2num(arr{2});
	xy = [arr1 arr2];
	XY = [XY; xy];
end;

X = XY(:,1:9);
y = XY(:,10);

save("-mat", "cancer.mat", "X", "y");
