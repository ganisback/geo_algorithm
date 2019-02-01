package com.betagis.mapplugin.geoalgorithm;

import com.vividsolutions.jts.geom.Coordinate;
import com.vividsolutions.jts.geom.Geometry;
import com.vividsolutions.jts.geom.GeometryFactory;
import com.vividsolutions.jts.geom.Polygon;
import com.vividsolutions.jts.geom.util.LineStringExtracter;
import com.vividsolutions.jts.operation.polygonize.Polygonizer;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

public class GeoUtil {
    public static List<double[]> getUnion(ArrayList<List<Double>> polygons0,ArrayList<List<Double>> polygons1){
        List<Coordinate> coordinates1 = new ArrayList<>();
        List<Coordinate> coordinates2= new ArrayList<>();
        for(List<Double> coordinate:polygons0){
            coordinates1.add(new Coordinate(Double.valueOf(coordinate.get(0)),Double.valueOf(coordinate.get(1))));
        }
        for(List<Double> coordinate:polygons1){
            coordinates2.add(new Coordinate(Double.valueOf(coordinate.get(0)),Double.valueOf(coordinate.get(1))));
        }
        Polygon p1 = new GeometryFactory().createPolygon(coordinates1.toArray(new Coordinate[0]));
        Polygon p2 = new GeometryFactory().createPolygon(coordinates2.toArray(new Coordinate[0]));
// calculate union
        Geometry union = p1.union(p2);
        List<double[]> unionPoints = new ArrayList<>();
        for(Coordinate co:union.getCoordinates()){
            unionPoints.add(new double[]{co.x,co.y});
        }
        return unionPoints;

    }

    public static List<List<double[]>> getDissolvePolygon(ArrayList<List<Double>> polygons0,ArrayList<List<Double>> line0){
        List<Coordinate> coordinates1 = new ArrayList<>();
        List<Coordinate> coordinates2= new ArrayList<>();
        for(List<Double> coordinate:polygons0){
            coordinates1.add(new Coordinate(Double.valueOf(coordinate.get(0)),Double.valueOf(coordinate.get(1))));
        }
        for(List<Double> coordinate:line0){
            coordinates2.add(new Coordinate(Double.valueOf(coordinate.get(0)),Double.valueOf(coordinate.get(1))));
        }
        Polygon poly = new GeometryFactory().createPolygon(coordinates1.toArray(new Coordinate[0]));
        Geometry line = new GeometryFactory().createLineString(coordinates2.toArray(new Coordinate[0]));



        Geometry nodedLinework = poly.getBoundary().union(line);
        Geometry polys = polygonize(nodedLinework);

        List<List<double[]>> myResult = new ArrayList<>();

        // Only keep polygons which are inside the input
        List output = new ArrayList();
        for (int i = 0; i < polys.getNumGeometries(); i++) {
            Polygon candpoly = (Polygon) polys.getGeometryN(i);
            if (poly.contains(candpoly.getInteriorPoint())) {
                List<double[]> polyPoints = new ArrayList<>();
                for(Coordinate co:candpoly.getCoordinates()){
                    polyPoints.add(new double[]{co.x,co.y});

                }
                myResult.add(polyPoints);
            }
        }


        return myResult;

    }

    public static Geometry polygonize(Geometry geometry) {
        List lines = LineStringExtracter.getLines(geometry);
        Polygonizer polygonizer = new Polygonizer();
        polygonizer.add(lines);
        Collection polys = polygonizer.getPolygons();
        Polygon[] polyArray = GeometryFactory.toPolygonArray(polys);
        return geometry.getFactory().createGeometryCollection(polyArray);
    }

    public static void main(String[] args) {
        ArrayList<List<Double>> polygons0=new ArrayList<>();
        ArrayList<List<Double>> polygons1=new ArrayList<>();
        polygons0.add(new ArrayList<Double>(Arrays.asList(61.0,68.0)));
        polygons0.add(new ArrayList<Double>(Arrays.asList(145.0, 122.0)));
        polygons0.add(new ArrayList<Double>(Arrays.asList(186.0, 94.0)));
        polygons0.add(new ArrayList<Double>(Arrays.asList(224.0, 135.0)));
        polygons0.add(new ArrayList<Double>(Arrays.asList(204.0, 211.0)));
        polygons0.add(new ArrayList<Double>(Arrays.asList(105.0, 200.0)));
        polygons0.add(new ArrayList<Double>(Arrays.asList(141.0, 163.0)));
        polygons0.add(new ArrayList<Double>(Arrays.asList(48.0, 139.0)));
        polygons0.add(new ArrayList<Double>(Arrays.asList(74.0, 117.0)));

        polygons1.add(new ArrayList<Double>(Arrays.asList(131.0, 84.0)));
        polygons1.add(new ArrayList<Double>(Arrays.asList(224.0, 110.0)));
        polygons1.add(new ArrayList<Double>(Arrays.asList(174.0, 180.0)));
        polygons1.add(new ArrayList<Double>(Arrays.asList(120.0, 136.0)));
        polygons1.add(new ArrayList<Double>(Arrays.asList(60.0, 167.0)));
        polygons1.add(new ArrayList<Double>(Arrays.asList(131.0, 85.0)));

        getUnion(polygons0,polygons0);

    }


}
