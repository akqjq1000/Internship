package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Collections;

import dto.Clients;

public class ClientsDAO {
	public Clients getMaximumTraffic(LocalDate date) {
		Clients maxClients = new Clients();

		try {
			Connection connection = GetConnection.getConnection();
			String sql = "SELECT * FROM ap_using_person WHERE DATE(current_times) = '" + date + "' ORDER BY cnt DESC LIMIT 1";
			PreparedStatement pstmt = connection.prepareStatement(sql);
			ResultSet resultSet = pstmt.executeQuery();
			
			if (resultSet.next()) {
				maxClients.setNo(resultSet.getInt("no"));
				maxClients.setCnt(resultSet.getInt("cnt"));
				maxClients.setCurrent_times(resultSet.getTimestamp("current_times"));
				maxClients.setTx(resultSet.getString("tx"));
				maxClients.setRx(resultSet.getString("rx"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return maxClients;
	}

	public ArrayList<Double> getTrafficData(LocalDate today, String trafficKind) {
		ArrayList<Clients> todayClientsList = getClientsList(today);
		ArrayList<String> trafficList = new ArrayList<>(Collections.nCopies(48, null));

		ArrayList<Double> traffic = new ArrayList<>(Collections.nCopies(48, null));

		for (Clients c : todayClientsList) {
			if (c == null) {
				continue;
			} else {
				int index = ClientsDAO.getCountValue(c.getCurrent_times());

				if (trafficKind.equals("tx")) {
					trafficList.set(index, c.getTx());
				} else {
					trafficList.set(index, c.getRx());
				}

				for (String t : trafficList) {
					if (t != null) {
						String[] splitData = t.split(" ");
						double trafficValue = Double.parseDouble(splitData[0]);
						String unit = splitData[1];

						traffic.set(index, unit.equals("MB") ? trafficValue / 1024 : trafficValue);
					}
				}
			}
		}

		return traffic;
	}

	public ArrayList<Clients> getClientsList(LocalDate today) {
		Connection connection = null;
		ResultSet resultSet = null;
		PreparedStatement pstmt = null;
		ArrayList<Clients> clientsList = initializeClientsList();
		try {
			connection = GetConnection.getConnection();
			String sql = "SELECT * FROM ap_using_person WHERE DATE(current_times) = '" + today.toString() + "'";
			pstmt = connection.prepareStatement(sql);
			resultSet = pstmt.executeQuery();

			while (resultSet.next()) {
				Clients clients = new Clients();
				clients.setNo(resultSet.getInt("no"));
				clients.setCnt(resultSet.getInt("cnt"));
				clients.setCurrent_times(resultSet.getTimestamp("current_times"));
				clients.setRx(resultSet.getString("rx"));
				clients.setTx(resultSet.getString("tx"));
				clientsList.set(getCountValue(resultSet.getTimestamp("current_times")), clients);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return clientsList;
	}

	public ArrayList<Integer> getClients(LocalDate today) {
		Connection connection = null;
		ResultSet resultSet = null;
		PreparedStatement pstmt = null;
		ArrayList<Integer> clients = initializeClients();
		try {
			connection = GetConnection.getConnection();
			String sql = "SELECT * FROM ap_using_person WHERE DATE(current_times) = '" + today.toString() + "'";
			pstmt = connection.prepareStatement(sql);
			resultSet = pstmt.executeQuery();
			while (resultSet.next()) {
				clients.set(getCountValue(resultSet.getTimestamp("current_times")), resultSet.getInt("cnt"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return clients;
	}

	public static ArrayList<Integer> initializeClients() {
		ArrayList<Integer> clients = new ArrayList<>(Collections.nCopies(48, 0));
		return clients;
	}

	public static ArrayList<Clients> initializeClientsList() {
		ArrayList<Clients> clients = new ArrayList<>(Collections.nCopies(48, null));
		return clients;
	}

	public static int getCountValue(Timestamp current_times) {

		// Timestamp를 LocalDateTime으로 변환
		LocalDateTime currentTime = current_times.toLocalDateTime();

		// 시작 시간을 00:00:00으로 설정
		LocalDateTime startTime = currentTime.with(LocalTime.MIDNIGHT);

		// 30분 간격으로 카운트 값 계산
		long minutes = ChronoUnit.MINUTES.between(startTime, currentTime);
		int count = (int) (minutes / 30);

		return count;
	}
}
