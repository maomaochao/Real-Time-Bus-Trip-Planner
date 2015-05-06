package model;

import java.util.Arrays;
import java.util.Comparator;

import org.genericdao.ConnectionPool;
import org.genericdao.DAOException;
import org.genericdao.GenericDAO;
import org.genericdao.MatchArg;
import org.genericdao.RollbackException;

import databean.Location;


public class LocationDAO extends GenericDAO<Location>{

	private ComparePrice comparePriceDSC = new ComparePrice(false);
	public LocationDAO(ConnectionPool cp, String tableName) throws DAOException {
		super(Location.class, tableName, cp);
	}
	
	// Return all locations available
	public Location[] read() throws RollbackException {
		Location[] locations= match();
		return locations;
	}
	public int numOfLocation(String location) throws RollbackException {
		Location[] loc= match(MatchArg.equals("locName", location));
		return loc.length;
	}
	public Location getCount(String location) throws RollbackException {
		Location[] loc= match(MatchArg.equals("locName", location));
		return loc[0];
	}
	public void changeLocationNumber(int locationId, int count) {
		try {
			Location loc= read(locationId);
			if(loc== null) {
				throw new RollbackException("No such location exist.");
			}
			
			loc.setCount(count);
			update(loc);
		} catch (RollbackException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public Location[] getTopTen() throws RollbackException{
		Location[] loc= read();
		if(loc==null || loc.length == 0) {
			return null;
		}
		Arrays.sort(loc,comparePriceDSC);
		Location[] newLoc= new Location[loc.length];
		for(int i=0; i<loc.length; i++) {
			/*System.out.println(loc[i]);*/
			newLoc[i]=loc[i];
		}
		return newLoc;
	}
	
	private static class ComparePrice implements Comparator<Location> {
		private boolean ascending;
		
		public ComparePrice(boolean ascending) {
			this.ascending = ascending;
		}
		
		// Sorts by price then firstname or spouse's last then spouse's first,
		// depending on setting of spouseCompare variable.
		public int compare(Location e1, Location e2) {
			int lastCompare;
			
			if (ascending) {
				lastCompare = comparePrice(e1.getCount(),e2.getCount());
			} else {
				lastCompare = comparePrice(e2.getCount(),e1.getCount());
			}			
			return lastCompare;			
		}
		
		private int comparePrice(Integer n1, Integer n2) {
			// The application never stores null names in the database, but
/*			// just in case someone puts a null name in there...
			if (n1 == null && n2 == null) return 0;
			if (n1 == null) return -1;
			if (n2 == null) return 1;*/
			return n1.compareTo(n2);
		}
	};
}
