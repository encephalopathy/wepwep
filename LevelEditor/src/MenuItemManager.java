import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JMenu;
import javax.swing.JMenuItem;


public class MenuItemManager {
	public void CreateMenuItem(JMenu menu, String name){
		JMenuItem newItem = new JMenuItem(name);
		menu.add(newItem);
	}
	
	public void DeleteMenuItem(JMenu menu, JMenuItem item){
		menu.remove(item);
	}
	
	public void CreateEnemyMenuItem(JMenu menu, String name /*Enemy Object*/){
		
	}
	
	public void CreateWaveMenuItem(JMenu menu, String name){
		JMenuItem newItem = new JMenuItem(name);
		menu.add(newItem);
		newItem.addActionListener(new ActionListener() {
	           @Override
	           public void actionPerformed(ActionEvent event) {
	               //enemyChoiceMenu.setText("Honkey");
	          }
		});

	}
}
