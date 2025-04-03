function aoiData = FindMatrixDataInAOI(x,y,x_roi,y_roi,inData)
% Algorithm of XY calaculation
row=1;
for i=1:size(x)
    for j=1:size(y)
        xy(row,:)=[x(i) y(j)];
        rcIdx(row,:)=[i j];
        row=row+1;
    end
end

[in, ~]=inpolygon(xy(:,1),xy(:,2),x_roi,y_roi);

a=rcIdx(:,1);
b=rcIdx(:,2);
rc_in_roi=[a(in) b(in)];

aoiData=NaN(size(inData));
for i = 1:length(rc_in_roi)
    aoiData(rc_in_roi(i,1),rc_in_roi(i,2))=1;
end
aoiData=aoiData.*inData;

end