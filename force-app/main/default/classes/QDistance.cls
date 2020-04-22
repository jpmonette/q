/**
* QDistance support distance filters
* @author  Fred Hays
* @since   2020-04-22
*/

public class QDistance extends QCondition {
    
    public enum Unit { mi, km }

    private Unit distanceUnit;

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

    public QDistance(String fromLocationField, String toLocationField, QDistance.Unit unit) {
        this(fromLocationField, toLocationField, null, null, unit);
    }

    public QDistance(String fromLocationField, Decimal toLat, Decimal toLon, QDistance.Unit unit) {
        this(fromLocationField, null, toLat, toLon, unit);
    }

    private QDistance(String fromLocationField, String toLocationField, Decimal toLat, Decimal toLon, QDistance.Unit unit) {
        super(fromLocationField);
        this.toLocationField = toLocationField;
        this.toLocationLatitude = toLat;
        this.toLocationLongitude = toLon;
        this.distanceUnit = unit;
    }

    public override String build() {
        String geolocation = '';

        if (String.isEmpty(this.toLocationField)) {
            geolocation = String.format('GEOLOCATION({0}, {1})', new String[]{
                String.valueOf(this.toLocationLatitude), String.valueOf(this.toLocationLongitude)
            });
        } else {
            geolocation = this.toLocationField;
        }

        String distance = 'DISTANCE(' + super.field + ', ' + geolocation + ', \'' + String.valueOf(this.distanceUnit) + '\')';

        if (super.operatorValue.equals(ComparisonOperator.LESS_THAN)) {
            return distance + ' < ' + super.fieldValue;
        } else if (super.operatorValue.equals(ComparisonOperator.GREATER_THAN)) {
            return distance + ' > ' + super.fieldValue;
        }
        throw new QDistanceException('Invalid operator. DISTANCE supports only the logical operators > and <');
    }

    public class QDistanceException extends Exception {}

}
