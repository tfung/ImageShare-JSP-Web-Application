package imageshare.oraclehandler;

import imageshare.model.Image;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.Date;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Vector;

import javax.imageio.ImageIO;

public class OracleHandler {
	
	private static final String ORACLE_DRIVER = "oracle.jdbc.driver.OracleDriver";
	//private static final String CONNECTION_STRING = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS"; // use for University
	private static final String CONNECTION_STRING = "jdbc:oracle:thin:@localhost:1521:CRS"; // use for SSH
	private static final String USERNAME = "jyuen";
	private static final String PASSWORD = "pass2014";

	// Singleton
	private static OracleHandler oracleHandler = null;
	private Connection conn;
	
	/**
	 * Prevents instantiation - singleton model
	 */
	protected OracleHandler() {}
	
    /**
     * @return the singleton OracleHandler
     */
	public static OracleHandler getInstance() {
	    if (oracleHandler == null) {
	        oracleHandler = new OracleHandler();
	        oracleHandler.establishConnection();
	    }
	    return oracleHandler;
	}
	
    private void establishConnection() {
        try {
            Class<?> drvClass = Class.forName(ORACLE_DRIVER);
            DriverManager.registerDriver((Driver) drvClass.newInstance());
            oracleHandler.conn = DriverManager.getConnection(CONNECTION_STRING,
                    USERNAME, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // TODO call on logout?
    public void closeConnection() {
        try {
            oracleHandler.conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    /**
     * @param statement
     *            Insert statement to insert a record into the Oracle database
     */
    public void insertRecord(String statement) throws Exception {
        PreparedStatement stmt = oracleHandler.conn.prepareStatement(statement);
        stmt.executeUpdate();
        stmt.execute("commit");
    }

    /**
     * @param statement
     *            Query statement use to query Oracle database
     */
	public Vector<Vector<String>> retrieveResultSet(String statement) throws Exception {
        Vector<Vector<String>> resultVector = null;

        PreparedStatement stmt = oracleHandler.conn.prepareStatement(statement);
        ResultSet rset = stmt.executeQuery(statement);

        ResultSetMetaData rsmd = rset.getMetaData();
        resultVector = new Vector<Vector<String>>();

        int colCount = rsmd.getColumnCount();

        // algorithm could be improved.
        // if unknown oracle type comes up, google the type number and add it
        // to the else if statements
        while (rset.next()) {
            Vector<String> resultRow = new Vector<String>();

            for (int i = 1; i <= colCount; i++) {
                if (rsmd.getColumnType(i) == Types.INTEGER) {
                    resultRow.add("" + rset.getInt(i));
                } else if (rsmd.getColumnType(i) == Types.VARCHAR) {
                    resultRow.add(rset.getString(i));
                } else if (rsmd.getColumnType(i) == Types.TIMESTAMP) {
                    resultRow.add(rset.getTimestamp(i).toString());
                } else {
                    throw new Exception("UKNOWN ORACLE TYPE: "
                            + rsmd.getColumnType(i));
                }
            }

            resultVector.add(resultRow);
        }

        stmt.close();

        return resultVector;
	}

    /**
     * Executes a generic query.
     * 
     * @param query
     *            sql to execute
     * @return the result set
     * @throws Exception
     *             exception if there was trouble executed the query. Caller
     *             expected to handle.
     */
    public ResultSet executeQuery(String query) throws Exception {
        PreparedStatement stmt = oracleHandler.conn.prepareStatement(query);
        return stmt.executeQuery(query);
    }
	
    /**
     * Stores the image into the database
     * 
     * @param image
     *            The image to store
     */
    public void storeImage(Image image) throws Exception {
        String query = "INSERT INTO IMAGES VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        int imageID = oracleHandler.nextImageID();

        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        ImageIO.write(image.getImage(), "jpg", baos);
        InputStream imageInputStream = new ByteArrayInputStream(
                baos.toByteArray());

        ImageIO.write(image.getThumbnail(), "jpg", baos);
        InputStream thumbnailInputStream = new ByteArrayInputStream(
                baos.toByteArray());

        PreparedStatement stmt = oracleHandler.conn.prepareStatement(query);
        stmt.setInt(1, imageID);
        stmt.setString(2, image.getOwnerName());
        stmt.setInt(3, image.getPermitted());
        stmt.setString(4, image.getSubject());
        stmt.setString(5, image.getPlace());
        stmt.setDate(6, new Date(image.getDate().getTime()));
        stmt.setString(7, image.getDescription());
        stmt.setBinaryStream(8, imageInputStream);
        stmt.setBinaryStream(9, thumbnailInputStream);

        stmt.executeUpdate();
    }
    
    /**
     * @return the next image id
     * @throws Exception
     */
    public int nextImageID() throws Exception {
        String sql = "SELECT image_sequence.nextval from dual";
        ResultSet rs = executeQuery(sql);
        rs.next();
        return rs.getInt(1);
    }
}