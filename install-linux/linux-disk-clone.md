# Using Rescuezilla (Recommended, GUI, Easiest)

Rescuezilla is the graphical version of Clonezilla. It is very user-friendly, similar to using Ghost or DiskGenius on Windows.

#### 1. Preparation

- Download the **Rescuezilla ISO image**.
- Use a tool (like **Etcher** or **Rufus**) to write the ISO to an empty USB drive to create a bootable drive.
- Connect both the **500GB external hard drive** (Source) and the **2TB system hard drive** (Target) to the computer.
- Insert the USB drive, restart the computer, enter BIOS settings, and boot from the USB drive.

> Refus 烧录
>
> - linux mint
> - GPT
> - Fat32 / exFat
> - DD Image mode
> - Try ` Graphical Fallback Mode`

#### 2. Start Cloning

1. After booting into Rescuezilla, select your language (English is usually default).
2. Click the **"Clone"** icon.
3. **Select Source Drive:** Be very careful here. Select the **500GB external drive**. Click Next.
4. **Select Destination Drive (Target):** Select the **2TB system drive**. Click Next.
   - *Note: All data on the destination drive will be erased.*
5. The software will ask you to confirm the partition layout. Once confirmed, start cloning.

#### 3. Resize Partitions (Expand Storage)

After cloning is complete, 500GB of data will be written to your 2TB drive. The remaining 1.5TB will show as "Unallocated" space.

1. **Do not restart yet.** Rescuezilla has a built-in partition tool called **GParted** (usually found in the Start Menu).
2. Open **GParted** and select your **2TB drive** (from the dropdown menu in the top right).
3. You will see a large block of gray unallocated space at the end.
4. Right-click on your main partition (usually `ext4` format, often the largest partition), and select **"Resize/Move"**.
5. Drag the slider (or the right edge of the box) all the way to the right to fill the entire 2TB space.
6. Click **Resize**, and then click the **Apply** (checkmark icon) button in the toolbar to execute the changes.

#### 4. Finish

Shut down the computer, unplug the USB drive and the 500GB external drive, and boot up the system normally.

# automatic mounting

Here is the step-by-step guide to setting up **automatic mounting** on startup in Linux Mint, so you don't have to manually double-click the drive every time you reboot.

We will use the built-in **Disks** tool. This is the safest way to ensure the drive mounts to the exact path your Python script expects (`/media/hsiong/JF-Disk`) with the correct write permissions.

### Step 1: Open the "Disks" Utility

1. Open your **Menu** (Start menu).
2. Search for **"Disks"** and open it.

### Step 2: Select Your Drive

1. In the left sidebar, click on your hard drive (the one containing `JF-Disk`).
2. On the right side diagram, click to select the specific **partition** labeled `JF-Disk`.
3. Click the **Gear Icon ⚙️** (Additional Partition Options) located below the partition diagram.
4. Select **"Edit Mount Options..."**.

### Step 3: Configure Auto-Mount settings

A new window will pop up. Follow these settings strictly:

1. **User Session Defaults:** Turn this switch **OFF**.
2. **Mount at system startup:** Ensure this is **Checked**.
3. **Display Name:** You can leave this as is (e.g., "JF-Disk").
4. **Mount Point:** **(Crucial!)** Change this to exactly: `/media/hsiong/JF-Disk` *Note: Your Python script relies on this specific path. If "Disks" sets it to something else by default, you must change it here.*

### Step 4: Fix Permissions (To avoid "Permission Denied")

Look at the text field labeled only with a comma-separated list (e.g., `nosuid,nodev...`).

- **If your drive is NTFS or exFAT (Windows format):** Linux often mounts these as "root" only. To fix this for your user (`hsiong`), add the following text to the end of that line (separated by a comma):

  `uid=1000,gid=1000`

  *Full example line:* `nosuid,nodev,nofail,x-gvfs-show,uid=1000,gid=1000`

- **If your drive is ext4 (Linux format):** You can leave the options as default.

### Step 5: Save and Reboot

1. Click **OK**.
2. Enter your password when prompted.
3. **Reboot your computer.**

### Verification

After restarting, **do not** click the drive icon. Open a terminal immediately and run:

Bash

```
ls -l /media/hsiong/JF-Disk
```
