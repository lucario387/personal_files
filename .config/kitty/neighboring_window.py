from kittens.tui.handler import result_handler
from typing import List, cast
from kitty.boss import Boss
from kitty.typing import EdgeLiteral


def main(args: List[str]) -> None:
    pass

@result_handler(no_ui=True)
def handle_result(args: List[str], result: str, target_window_id: int, boss: Boss) -> None:
    boss.active_tab.neighboring_window(cast(EdgeLiteral, args[1]))
