# CS2-Linux

A utility for automatically running `.sh` scripts when the **Counter-Strike 2** (CS2) window gains or loses focus on Ubuntu (X11).

## Features
- Automatically executes scripts when switching focus to or from the CS2 window.
- Includes:
  - Disabling the Super key when CS2 is focused.
  - Switching between 4:3 and 16:9 resolutions.

Designed to work under X11 on Ubuntu.

## Usage

1. **Copy Scripts**: The `/scripts/` folder containing the scripts can be placed anywhere on your system.
2. **Set Permissions**: Ensure all files in the [`/scripts/`](./scripts) directory have execution permissions:

    ```bash
    chmod +x ./scripts/*.sh
    ```

3. **Run Focus Listener**: Start the focus listener script manually:

    ```bash
    ./scripts/cs2-focus-listener.sh
    ```

    - When the CS2 window gains focus, [`focus-cs2.sh`](./scripts/focus-cs2.sh) will execute.
    - When the CS2 window loses focus, [`unfocus-cs2.sh`](./scripts/unfocus-cs2.sh) will run.

## Autostart at User Login
To automatically run the focus listener service on login:

1. **Move Service File**: Place the `cs2-focus-listener.service` file under `/etc/systemd/user/`

2. **Modify Paths**: Update the paths in [`cs2-focus-listener.service`](./etc/systemd/user/cs2-focus-listener.service) to match the location of your scripts.

3. **Reload Daemon**: Reload systemd to recognize the new service:

    ```bash
    systemctl --user daemon-reload
    ```

4. **Enable Service on Login**: Add the following command to **Startup Applications**:

    ```bash
    systemctl --user start cs2-focus-listener.service
    ```

    To start the service immediately without waiting for the next login, run the same command.

5. **Check Service Status**: Verify if the service is active:

    ```bash
    systemctl --user status cs2-focus-listener.service
    ```

This setup ensures that the service starts automatically when you log in.
