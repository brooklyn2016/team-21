import java.io.File;
import java.io.FileInputStream;
//import com.musicg.*;
import com.musicg.wave.*;
import com.musicg.wave.Wave;
import com.musicg.fingerprint.*;
import java.util.Scanner;
import java.io.FileNotFoundException;

public class matcher {
	
	public static float getSimilarity(Wave input, Fingerprint out) {
		return 0;
	}

	public static float getSimilarity(FileInputStream f1, FileInputStream f2) {
		Wave r1 = new Wave(f1); Wave r2 = new Wave(f2);
		FingerprintSimilarity Similarity = r1.getFingerprintSimilarity(r2);
		return Similarity.getSimilarity();
	}

	public static void main(String[] args) throws FileNotFoundException {
		Scanner in = new Scanner(System.in);
		String path = "./Sample Recordings/";
		/*System.out.println("Enter file1: ");
		String file1 = in.nextLine();
		System.out.println("Enter file2: ");
		String file2 = in.nextLine();
		in.close();*/

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
		}
		
	}
}
