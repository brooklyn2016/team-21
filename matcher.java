import java.io.File;
import java.io.FileInputStream;
//import com.musicg.*;
import com.musicg.wave.*;
import com.musicg.wave.Wave;
import com.musicg.fingerprint.*;
import java.util.Scanner;
import java.io.FileNotFoundException;
import java.util.Arrays;
import java.io.*;
import java.nio.charset.Charset;
import java.nio.charset.CharsetEncoder;
import java.nio.CharBuffer;

public class matcher {
	
	public static byte[] hexStringToByteArray(String s) {
		 int len = s.length();
		 byte[] data = new byte[len / 2];
		 for (int i = 0; i < len; i += 2) {
			 data[i / 2] = (byte) ((Character.digit(s.charAt(i), 16) << 4)
				 + Character.digit(s.charAt(i+1), 16));
		 }
		return data;
	}
	
	/*final protected static char[] hexArray = "0123456789ABCDEF".toCharArray();
	public static String bytesToHex(byte[] bytes) {
		char[] hexChars = new char[bytes.length * 2];
		for ( int j = 0; j < bytes.length; j++ ) {
			int v = bytes[j] & 0xFF;
			hexChars[j * 2] = hexArray[v >>> 4];
			hexChars[j * 2 + 1] = hexArray[v & 0x0F];
		}
		 return new String(hexChars);
	}*/

	public static String bytesToHex(byte[] bytes) {
		StringBuilder hexStr = new StringBuilder(bytes.length);
		int v; String hex;
		for ( int j = 0; j < bytes.length; j++ ) {
			v = bytes[j] & 0xFF; // get the byte
			 //Get the last two bytes of the hex number
			 hex = Integer.toHexString(0x100 | v).substring(1);
			 hexStr.append(hex);
		 }
		 return hexStr.toString();
	}
	
	public static int hexCharToInt(char c) {
		if (c >= '0' && c <= '9')
		{
			    return c - '0';
		}
		if (c >= 'a' && c <= 'f')
		{
			    return c - 'a' + 10;
		}
		if (c >= 'A' && c <= 'F')
		{
			    return c - 'A' + 10;
		}
		return 0;
	}

	public static byte[] str_to_bb(String msg) {
		byte[] arr = new byte[msg.length()/2 + 1];
		int i = 0;
		System.out.println(msg.length());
		for(int j = 0; j < msg.length(); j+=2) {
			//System.out.println(j);
			int s = hexCharToInt(msg.charAt(j));
			int p = hexCharToInt(msg.charAt(j+1));
			//System.out.println(s + " " + p);
			arr[i] = (byte)(16*s+p);
			i++;
		}
		return arr;
	}

	public static byte[] serialize(Object obj) {
		try(ByteArrayOutputStream b = new ByteArrayOutputStream()){
			 try(ObjectOutputStream o = new ObjectOutputStream(b)){
				o.writeObject(obj); 
			 }
			 return b.toByteArray();
		 } catch(IOException ie) {
			System.out.println(ie);
		 }
		return null;
	}
	
	public static float getSimilarity(Wave input, byte[] out) {
		byte[] inputFingerprint = input.getFingerprint();	
		float match = new FingerprintSimilarityComputer(inputFingerprint,
			out).getFingerprintsSimilarity().getSimilarity();

		return match;
	}

	public static float getSimilarity(FileInputStream f1, FileInputStream f2) {
		Wave r1 = new Wave(f1); Wave r2 = new Wave(f2);
		System.out.println(serialize(r1.getFingerprint()).length);
		System.out.println(serialize(r2.getFingerprint()).length);
		FingerprintSimilarity Similarity = r1.getFingerprintSimilarity(r2);
		return Similarity.getSimilarity();
	}

	public static void main(String[] args) throws FileNotFoundException {
		/*Scanner in = new Scanner(System.in);
		String path = "./Sample Recordings/";
		/*System.out.println("Enter file1: ");
		String file1 = in.nextLine();
		System.out.println("Enter file2: ");
		String file2 = in.nextLine();
		in.close();

		File folder = new File(path);
		File[] listOfFiles = folder.listFiles();

		for(int i = 0; i < listOfFiles.length; i++) {
			File file1 = listOfFiles[i];
			String file1Name = file1.getName();
			System.out.println(file1Name);
			for(int j = 0; j < listOfFiles.length; j++) {
				File file2 = listOfFiles[j];
				String file2Name = file2.getName();
		System.out.print("\n\t" + file2Name + " " + getSimilarity(new FileInputStream(file1),
					new FileInputStream(file2)) );

			}
			System.out.println();
		}*/
		//System.out.println(args.length);
		//System.out.println(Arrays.toString(args));
		String wavFileName = args[1];
		Wave inputWave = new Wave(new FileInputStream(new File(wavFileName)));				
		switch(args[0]) {
			case "getSimilarity":
				String[] fingerPrints = args[2].split(",");
				int maxMatch = 0;
				for(String s : fingerPrints) {
					byte[] fp = str_to_bb(s);
					//System.out.println(Arrays.toString(fp));
					float match = getSimilarity(inputWave, fp);
				}
				System.out.println(maxMatch);
				break;
			case "getFingerPrint":
				byte[] fp = inputWave.getFingerprint();
				System.out.println(Arrays.toString(fp));
				//System.out.println(bytesToHex(fp));
				//System.out.println(fp.length);
				break;
		}
		
	}
}
