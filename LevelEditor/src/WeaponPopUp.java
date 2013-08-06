import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JCheckBox;
import javax.swing.JMenuBar;
import javax.swing.JMenu;
import javax.swing.JMenuItem;

import java.io.*;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;


public class WeaponPopUp extends JDialog {
	
	public JMenu[] weaponCapacity; //number of weapons an enemy ship can carry
	public JMenuItem[] availableWeapons; //array of ALL weapons available
	public String[] weaponNames; //names of all the weapons the enemy has
	public String[] availableWeaponNames; //name of ALL weapons available
	WeaponPopUp self = null;
	
	private final JPanel contentPanel = new JPanel();

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) throws IOException{
		try {
			WeaponPopUp dialog = new WeaponPopUp(1);
			dialog.setDefaultCloseOperation(JDialog.DISPOSE_ON_CLOSE);
			dialog.setVisible(true);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * Create the dialog.
	 * @throws FileNotFoundException 
	 */
	public WeaponPopUp(int weapons) throws FileNotFoundException {
		self = this;
		final String dir = System.getProperty("user.dir");
        System.out.println("current dir = " + dir);
		Scanner in = new Scanner(new File("Weapons"));
		
		int lengthOfArray = Integer.parseInt(in.nextLine()); //grab the first line and convert to an int
		availableWeapons = new JMenuItem[lengthOfArray];
		availableWeaponNames = new String[lengthOfArray];
		
		for(int i = 0; i < lengthOfArray; i++){
			availableWeaponNames[i] = in.nextLine(); //parse over all the weaponNames to build the menu items
		}
		
		weaponCapacity = new JMenu[weapons];
		weaponNames = new String[weapons];
		for(int i = 0; i < weaponCapacity.length; i++){
			weaponCapacity[i] = new JMenu("Weapon" + (i+1));
		}
		for(int i = 0; i < weaponNames.length; i++){ weaponNames[i] = "none"; }
		
		setBounds(100, 100, 450, 300);
		getContentPane().setLayout(new BorderLayout());
		contentPanel.setLayout(new FlowLayout());
		contentPanel.setBorder(new EmptyBorder(5, 5, 5, 5));
		getContentPane().add(contentPanel, BorderLayout.CENTER);
		{
			JPanel buttonPane = new JPanel();
			buttonPane.setLayout(new FlowLayout(FlowLayout.RIGHT));
			getContentPane().add(buttonPane, BorderLayout.SOUTH);
			{
				/*
				JButton okButton = new JButton("OK");
				okButton.setActionCommand("OK");
				buttonPane.add(okButton);
				getRootPane().setDefaultButton(okButton);
				okButton.addActionListener(new ActionListener() {
					@Override
					public void actionPerformed(ActionEvent arg0) {
						
						
					}
				});
				*/
			}
			{
				/*
				JButton cancelButton = new JButton("Cancel");
				cancelButton.setActionCommand("Cancel");
				buttonPane.add(cancelButton);
				*/
			}
		}
		{

			JMenuBar menuBar = new JMenuBar();
			setJMenuBar(menuBar);
			{
				for (int i = 0; i < weaponCapacity.length; i++){
					final int menuWeapon = i;
	
					menuBar.add(weaponCapacity[i]);
					{
						for(int j = 0; j < availableWeapons.length; j++){
							final int selectedWeapon = j;
							availableWeapons[j] = new JMenuItem(availableWeaponNames[j]);
							availableWeapons[j].addActionListener(new ActionListener(){
								@Override
								public void actionPerformed(ActionEvent e) {
									weaponNames[menuWeapon] = availableWeaponNames[selectedWeapon];
									weaponCapacity[menuWeapon].setText(availableWeaponNames[selectedWeapon]);
								}
							});
							weaponCapacity[i].add(availableWeapons[j]);
						}
					}
				}
			}
		}
	}
	
	public List<String> returnWeaponList(){
		ArrayList<String> weapons = new ArrayList<String>();
		for (int i = 0; i < weaponNames.length; i++){
			weapons.add(weaponNames[i]);
		}
		return weapons;
	}

}
