filename = "xor.in"
fid = fopen(filename);
ln = fgetl(fid);
XY = [];

for i=1:180
	ln = fgetl(fid);
	arr = strsplit(ln,":");
	arr1 = str2num(arr{1});
	arr2 = str2num(arr{2});
	xy = [arr1 arr2];
	XY = [XY; xy];
end;

X = XY(:,1:2);
y = XY(:,3);

save("-mat", "xor.mat", "X", "y");
