/**
* QDistance support distance filters
* @author  Fred Hays
* @since   2020-04-22
*/

public class QDistance extends QCondition {
	
	private String distanceUnit {
		private get;
		private set;
	}
	private String toLocationField { 
		private get; 
		private set; 
	}

	private Decimal toLocationLatitude { 
		private get; 
		private set; 
	}

	private Decimal toLocationLongitude { 
		private get; 
		private set; 
	}

	public QDistance(String fromLocationField) {
		super(fromLocationField);
		this.distanceUnit = 'mi';        
	}

	public QDistance to(String toLocationField) {
		this.toLocationField = toLocationField;
		return this;
	}

	public QDistance to(Decimal toLat, Decimal toLon) {
		this.toLocationLatitude = toLat;
		this.toLocationLongitude = toLon;
		return this;
	}

	public QDistance inMiles() {
		this.distanceUnit = 'mi';
		return this;
	}

	public QDistance inKilometers() {
		this.distanceUnit = 'km';
		return this;
	}

	public override String build() {
		if (String.isEmpty(this.toLocationField) && this.toLocationLatitude == null && this.toLocationLongitude == null) {
			throw new QDistanceException('To location is not set. Call to() method to set up.');
		}

		String geolocation = '';        

		if (String.isEmpty(this.toLocationField)) {
			geolocation = String.format('GEOLOCATION({0}, {1})', new String[]{
				String.valueOf(this.toLocationLatitude), String.valueOf(this.toLocationLongitude)
			});
		} else {
			geolocation = this.toLocationField;
		}

		String distance = 'DISTANCE(' + super.field + ', ' + geolocation + ', \'' + String.valueOf(this.distanceUnit) + '\')';

		switch on super.operatorValue {
			when LESS_THAN {
				return distance + ' < ' + super.fieldValue;
			}
			when GREATER_THAN {
				return distance + ' > ' + super.fieldValue;
			}
			when else {
				throw new QDistanceException('Invalid operator. DISTANCE supports only the logical operators > and <');
			}
		}
	}

	public class QDistanceException extends Exception {}

}