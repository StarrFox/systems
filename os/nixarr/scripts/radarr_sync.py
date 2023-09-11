#! /usr/bin/env nix-shell
#! nix-shell -i python3 -p python3

from os import environ, system


SYNC_COMMAND = "mullvad-exclude rsync --recursive --progress /data/ \"starrnix:/big/media/Movies\""


def on_download():
    file_path = environ.get("radarr_moviefile_path")

    if file_path is not None:
        print(f"New movie at path {file_path}")

    system(SYNC_COMMAND)


def main():
    event_type = environ.get("radarr_eventtype")

    if event_type is None:
        print("No event set")
        exit(1)

    match event_type:
        case "Test":
            print("Working!")
        case "Download":
            on_download()
        case _:
            print(f"unknown event type: {event_type}")


if __name__ == "__main__":
    main()
