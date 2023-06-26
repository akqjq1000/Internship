package dao;

import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.databind.ObjectMapper;

public class ClientsDAO {
	public static String CNT = "cnt";
	public static String NO = "no";
	public static String RX = "rx";
	public static String TX = "tx";
	public static String CURRENT_TIMES = "current_times";

	public String getData(String[] attArr, String startDate, String endDate) {
		String jsonResult = "";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = GetConnection.getConnection();

			// 쿼리 실행
			String query = "SELECT * FROM ap_using_person WHERE current_times >= '" + startDate
					+ "' AND current_times <= CONCAT('" + endDate + "', ' 23:59:59')";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();

			// 결과 데이터를 List<Map>으로 변환
			List<Map<String, Object>> resultList = new ArrayList<>();

			while (rs.next()) {
				Map<String, Object> row = new HashMap<>();
				for (String att : attArr) {
					if (att.equals(RX) || att.equals(TX)) {
						String value = rs.getString(att);
						double vlInGB = convertToGB(value);
						row.put(att, vlInGB);
					} else if (att.equals(CNT) || att.equals(NO)) {
						row.put(att, rs.getInt(att));
					} else if (att.equals(CURRENT_TIMES)){
						row.put(CURRENT_TIMES,
								new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getTimestamp(CURRENT_TIMES)));

					}
				}
				resultList.add(row);
			}

			// JSON 변환
			ObjectMapper objectMapper = new ObjectMapper();
			jsonResult = objectMapper.writeValueAsString(resultList);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 리소스 해제
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}

		return jsonResult;
	}

	private ResultSet getResultSetFromDatabase() throws SQLException {
		// 데이터베이스 연결 및 쿼리 실행 등 필요한 로직을 구현한다.
		// 이 예시에서는 단순히 ResultSet을 생성하여 반환한다.
		return null;
	}

	private double convertToGB(String value) {
		double size = Double.parseDouble(value.substring(0, value.length() - 3));
		if (value.endsWith("MB")) {
			size /= 1024; // MB를 GB로 변환한다.
		}
		return size;
	}

	private String formatValue(double value) {
		DecimalFormat decimalFormat = new DecimalFormat("0.00");
		decimalFormat.setRoundingMode(RoundingMode.DOWN);
		return decimalFormat.format(value) + " GB";
	}

	public String getBehindTheDateClientsToJSON(String startDate, String endDate) {
		String jsonResult = "";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = GetConnection.getConnection();

			// 쿼리 실행
			String query = "SELECT * FROM ap_using_person WHERE current_times >= '" + startDate
					+ "' AND current_times <= CONCAT('" + endDate + "', ' 23:59:59')";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();

			// 결과 데이터를 List<Map>으로 변환
			List<Map<String, Object>> resultList = new ArrayList<>();

			while (rs.next()) {
				Map<String, Object> row = new HashMap<>();
				row.put("no", rs.getInt("no"));
				row.put("cnt", rs.getInt("cnt"));
				row.put("rx", rs.getString("rx"));
				row.put("current_times",
						new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getTimestamp("current_times")));

				resultList.add(row);
			}

			// JSON 변환
			ObjectMapper objectMapper = new ObjectMapper();
			jsonResult = objectMapper.writeValueAsString(resultList);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 리소스 해제
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}

		return jsonResult;
	}
}
